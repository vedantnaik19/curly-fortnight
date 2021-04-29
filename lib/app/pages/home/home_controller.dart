import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../app/data/models/db_user.dart';
import '../../../app/data/services/firestore_service.dart';
import '../../../app/shared/services/sync_service.dart';
import '../../../app_controller.dart';

class HomeController extends GetxController {
  final SyncService _syncService = Get.find();
  final FirestoreService _firestoreService = Get.find();
  final AppController _appController = Get.find();
  StreamSubscription _connectivitySub;

  List<DocumentSnapshot> noteDocsSnap = [];
  Stream get notesStream => _firestoreService.getNotes();
  Rx<DbUser> get dbUser => _appController.dbUser;

  @override
  void onReady() {
    _appController.getDbUser();
    _listenConnectivity();
    super.onReady();
  }

  @override
  void onClose() {
    _connectivitySub?.cancel();
    super.onClose();
  }

  Future<void> syncImages() async {
    try {
      _syncService.syncImages(noteDocsSnap);
    } catch (e) {
      handleError(e, "Failed to sync images");
    }
  }

  Future<void> onLogout() async {
    try {
      _appController.signOut();
    } catch (e) {
      handleError(e);
    }
  }

  void handleError(e, [String message]) {
    GetUtils.printFunction("HomeController: ", e, message);
    _appController.showSnack(message ?? e.message ?? e.toString());
  }

  void _listenConnectivity() {
    _connectivitySub = _appController.hasConnection.listen((val) {
      syncImages();
    });
  }
}
