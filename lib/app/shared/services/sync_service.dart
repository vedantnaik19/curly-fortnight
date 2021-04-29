import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../app/data/models/note.dart';
import '../../../app/data/services/cloud_storage_service.dart';
import '../../../app/data/services/firestore_service.dart';
import '../../../app/utils/helper.dart';
import '../../../app_controller.dart';

class SyncService extends GetxService {
  final AppController _appController = Get.find();
  final CloudStorageService _cloudStorageService = Get.find();
  final FirestoreService _firestoreService = Get.find();

  bool _isUploadBusy = false;

  Future<void> syncImages(List<DocumentSnapshot> ds) async {
    if (!_isUploadBusy && _appController.hasConnection.value) {
      _isUploadBusy = true;
      for (int i = 0; i < ds.length; i++) {
        var note = Note.fromJson(ds[i].data());
        if (Helper.uploadImage(note)) {
          var file = File(note.image);
          if (file != null) {
            GetUtils.printFunction("Syncing image: ", note.id, note.image);
            var url = await _cloudStorageService.uploadImage(note, file);
            note = note.copyWith(image: url);
            _firestoreService.saveNote(note);
            GetUtils.printFunction("Image synced: ", note.id, note.image);
            file.delete();
          }
        }
      }
      _isUploadBusy = false;
    }
  }
}
