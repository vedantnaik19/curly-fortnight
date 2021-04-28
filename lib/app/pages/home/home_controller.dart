// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/core/services/auth_service.dart';
import 'package:stack_fin_notes/app/core/services/ui_service.dart';
import 'package:stack_fin_notes/app/data/services/firestore_service.dart';
import 'package:stack_fin_notes/app/shared/services/sync_Image_service.dart';

/// Controller
class HomeController extends GetxController {
  final UiService _uiService = Get.find();
  final FirestoreService _firestoreService = Get.find();
  final SyncImageService _notesService = Get.find();
  final AuthService _authService = Get.find();
  FirestoreService get firestoreService => _firestoreService;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String get photoURL => _authService.currentUser.photoURL;
  String get displayName => _authService.currentUser.displayName ?? "?";
  String get email => _authService.currentUser.email ?? "?";

  void syncImages(List<DocumentSnapshot> ds) {
    _notesService.syncImages(ds);
  }

  void onLogout() {
    _authService.signOut();
  }
}
