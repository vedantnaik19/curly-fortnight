import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/data/models/db_user.dart';
import 'package:stack_fin_notes/app/data/services/firestore_service.dart';
import './app/core/services/auth_service.dart';
import './app/shared/widgets/widget_helper.dart';

class AppController extends GetxController {
  final AuthService _authService = Get.find();
  final FirestoreService _firestoreService = Get.find();

  var _hasConnection = false.obs;
  StreamSubscription _connectivitySub;
  StreamSubscription<User> _userAuthSub;
  Rx<DbUser> _dbUser = Rx<DbUser>();

  RxBool get hasConnection => _hasConnection;
  User get currentUser => _authService.currentUser;
  Rx<DbUser> get dbUser => _dbUser;

  @override
  void onReady() {
    _listenConnectivity();
    _listenAuthChange();
    super.onReady();
  }

  @override
  onClose() {
    _connectivitySub?.cancel();
    _userAuthSub?.cancel();
    super.onClose();
  }

  showSnack(String message) {
    WidgetHelper.showSnack(message);
  }

  showLoader(bool val, [String msg = '']) {
    WidgetHelper.showLoader(val, msg);
  }

  void _listenConnectivity() {
    _connectivitySub = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        _hasConnection(true);
      } else {
        _hasConnection(false);
        showSnack("youOffline".tr);
      }
    });
  }

  void _listenAuthChange() {
    _userAuthSub = _authService.firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        GetUtils.printFunction("Current user: ", user.email ?? user.uid, "");
      } else {
        Get.offAllNamed('/login');
      }
    });
  }

  Future<void> signOut() async {
    await _authService.signOut();
    // clear storage
  }

  Future<void> getDbUser() async {
    try {
      _dbUser(await _firestoreService.getDbUser());
    } catch (e) {
      handleError(e);
    }
  }

  void handleError(e, [String message]) {
    GetUtils.printFunction("AppController: ", e, message);
    showLoader(false);
    if (e.toString().toLowerCase().contains('network'))
      message = "Please check your internet connection and try again!";
    showSnack(message ?? e.message ?? e.toString());
  }
}
