import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/core/services/connectivity_service.dart';
import 'package:stack_fin_notes/app/data/models/note.dart';
import 'package:stack_fin_notes/app/data/services/cloud_storage_service.dart';
import 'package:stack_fin_notes/app/data/services/firestore_service.dart';
import 'package:stack_fin_notes/app/shared/utils/helper.dart';

class SyncImageService extends GetxService {
  final CloudStorageService _cloudStorageService = Get.find();
  final FirestoreService _firestoreService = Get.find();
  final ConnectivityService _connectivityService = Get.find();
  bool _isUploadBusy = false;

  Future<void> syncImages(List<DocumentSnapshot> ds) async {
    if (!_isUploadBusy && _connectivityService.hasConnection) {
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

  void saveNote(Note note) {}
}
