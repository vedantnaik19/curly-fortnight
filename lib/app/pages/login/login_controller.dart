import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../app/core/services/auth_service.dart';
import '../../../app/data/models/db_user.dart';
import '../../../app/data/services/firestore_service.dart';
import '../../../app_controller.dart';

class LoginController extends GetxController {
  final AppController _appController = Get.find();
  final AuthService _authService = Get.find();
  final FirestoreService _firestoreService = Get.find();

  onGoogleSignIn() async {
    try {
      _appController.showLoader(true);
      var googleSignInAccount = await _authService.googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
            await _authService.firebaseAuth.signInWithCredential(credential);
        await syncUser(userCredential.user);
      }
      _appController.showLoader(false);
    } catch (e) {
      handleError(e, "Failed to login with Google.");
    }
  }

  signupWEmailPassword(email, password, name) async {
    try {
      _appController.showSnack("e.toString()");
      _appController.showLoader(true);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await syncUser(userCredential.user, name);
    } catch (e) {
      handleError(e, "Failed to signup.");
    }
  }

  void loginWEmailPassword(email, password) async {
    try {
      _appController.showLoader(true);
      UserCredential userCredential = await _authService.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      await syncUser(userCredential.user);
      _appController.showLoader(false);
    } catch (e) {
      handleError(e, "Failed to login.");
    }
  }

  void forgotPassword(email) async {
    try {
      _appController.showLoader(true);
      await _authService.firebaseAuth.sendPasswordResetEmail(email: email);
      _appController.showLoader(false);
      _appController.showSnack("passResetLink".tr);
      await Future.delayed(Duration(seconds: 4));
      Get.until((route) => Get.currentRoute == '/login');
    } catch (e) {
      handleError(e, "Failed to send password reset link");
    }
  }

  Future<void> syncUser(User user, [String name]) async {
    try {
      await _firestoreService.syncUser(
        DbUser(
            id: user.uid,
            email: user.email,
            name: name ?? user.displayName,
            photoUrl: user.photoURL),
      );
      Get.offAllNamed('/home');
    } catch (e) {
      handleError(e, "Failed to sync user.");
    }
  }

  void handleError(e, [String message]) {
    GetUtils.printFunction("LoginController: ", e, message);
    _appController.showLoader(false);
    if (e.toString().toLowerCase().contains('network'))
      message = "Please check your internet connection and try again!";
    _appController.showSnack(message ?? e);
  }
}
