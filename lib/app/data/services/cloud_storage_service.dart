import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/data/models/note.dart';

class CloudStorageService extends GetxService {
  final _storage = FirebaseStorage.instance;
  FirebaseStorage get storage => _storage;

  Future<String> uploadImage(Note note, File file) async {
    TaskSnapshot snapshot = await storage
        .ref()
        .child("images/${note.id}/image_${note.id}")
        .putFile(file);
    if (snapshot.state == TaskState.success) {
      return await snapshot.ref.getDownloadURL();
    } else {
      return null;
    }
  }

  deleteImage(Note note) async {
    if (Uri.parse(note.image).isAbsolute)
      await storage.ref().child("images/${note.id}/image_${note.id}").delete();
  }
}
