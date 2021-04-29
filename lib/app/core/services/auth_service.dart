import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get firebaseAuth => _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignIn get googleSignIn => _googleSignIn;

  User get currentUser => _auth.currentUser;

  bool get isAuthed => currentUser != null;

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
