import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stack_fin_notes/app/core/services/storage_service.dart';

class AuthService extends GetxService {
  final StorageService _storageService = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get firebaseAuth => _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignIn get googleSignIn => _googleSignIn;

  StreamSubscription<User> _userSub;

  User get currentUser => _auth.currentUser;

  bool get isAuthed => currentUser != null;

  @override
  onInit() {
    _userSub = _auth.authStateChanges().listen((user) {
      if (user != null) {
        GetUtils.printFunction("Current user: ", user.email ?? user.uid, "");
      } else {
        Get.offAllNamed('/login');
      }
    });
    super.onInit();
  }

  Future<void> signOut() async {
    try {
      _storageService.clearStorage();
      await _auth.signOut();
    } catch (e) {}
  }

  @override
  void onClose() {
    _userSub.cancel();
    super.onClose();
  }
}
