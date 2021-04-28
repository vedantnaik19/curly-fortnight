import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stack_fin_notes/app/core/services/auth_service.dart';
import 'package:stack_fin_notes/app/core/services/ui_service.dart';
import 'package:stack_fin_notes/app/data/services/firestore_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find();
  final UiService _uiService = Get.find();
  final FirestoreService _firestoreService = Get.find();

  onGoogleSignIn() async {
    try {
      _uiService.showLoader(true);
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
      _uiService.showLoader(false);
    } catch (e) {
      _uiService.showLoader(false);
      GetUtils.printFunction("LoginController: ", e, "onGoogleSignIn()");
      _uiService.showSnack(e?.code ?? e.toString());
    }
  }

  signupWEmailPassword(email, password, name) async {
    try {
      _uiService.showSnack("e.toString()");
      _uiService.showLoader(true);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await syncUser(userCredential.user, name);
    } catch (e) {
      _uiService.showLoader(false);
      _uiService.showSnack(e?.message ?? e.toString());
      GetUtils.printFunction("LoginController: ", e, "signupWEmailPassword()");
    }
  }

  void loginWEmailPassword(email, password) async {
    try {
      _uiService.showLoader(true);
      UserCredential userCredential = await _authService.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      await syncUser(userCredential.user);
      _uiService.showLoader(false);
    } catch (e) {
      GetUtils.printFunction("LoginController: ", e, "loginWEmailPassword()");
      _uiService.showLoader(false);
      _uiService.showSnack(e?.message ?? e.toString());
    }
  }

  void forgotPassword(email) async {
    try {
      _uiService.showLoader(true);
      await _authService.firebaseAuth.sendPasswordResetEmail(email: email);
      _uiService.showLoader(false);
      _uiService.showSnack("passResetLink".tr);
      await Future.delayed(Duration(seconds: 6));
      Get.until((route) => Get.currentRoute == '/login');
    } catch (e) {
      GetUtils.printFunction("LoginController: ", e, "forgotPassword()");
      _uiService.showLoader(false);
      _uiService.showSnack(e?.message ?? e.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> syncUser(User user, [String name]) async {
    try {
      await _firestoreService.syncUser(user, name);
      Get.offAllNamed('/home');
    } catch (e) {
      GetUtils.printFunction("LoginController: ", e, "loginWEmailPassword()");
      _uiService.showSnack(e?.message ?? e.toString());
    }
  }
}
