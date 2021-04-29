import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../app/data/services/firestore_service.dart';
import '../../../app/shared/services/sync_service.dart';
import '../../../app_controller.dart';

class HomeController extends GetxController {
  final SyncService _syncService = Get.find();
  final FirestoreService _firestoreService = Get.find();
  final AppController _appController = Get.find();

  Stream get notesStream => _firestoreService.getNotes();
  String get photoURL => _appController.photoURL;
  String get displayName => _appController.displayName;
  String get email => _appController.email;

  @override
  void onReady() {
    notesStream.listen((event) {
      _syncImages(event.docs);
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _syncImages(List<DocumentSnapshot> ds) {
    try {
      _syncService.syncImages(ds);
    } catch (e) {
      handleError(e, "Failed to sync images");
    }
  }

  void onLogout() {
    try {
      _appController.signOut();
    } catch (e) {
      handleError(e);
    }
  }

  void handleError(e, [String message]) {
    GetUtils.printFunction("HomeController: ", e, message);
    _appController.showSnack(message ?? e);
  }
}
