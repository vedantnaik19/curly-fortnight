// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stack_fin_notes/app/data/models/note.dart';
import 'package:stack_fin_notes/app/data/services/cloud_storage_service.dart';
import 'package:stack_fin_notes/app/data/services/firestore_service.dart';
import 'package:stack_fin_notes/app/shared/services/sync_Image_service.dart';
import 'package:stack_fin_notes/app/shared/utils/helper.dart';
import 'package:path/path.dart' as p;

/// Controller
class NoteDetailController extends GetxController {
  final FirestoreService _firestoreService = Get.find();
  final CloudStorageService _cloudStorageService = Get.find();
  final _titleController = TextEditingController();
  final _desController = TextEditingController();
  var _note = Note(
          id: Helper.generateNoteId(),
          createdAt: DateTime.now().millisecondsSinceEpoch)
      .obs;
  StreamSubscription _noteSub;

  TextEditingController get desController => _desController;
  TextEditingController get titleController => _titleController;
  Rx<Note> get note => _note;

  @override
  void onReady() {
    _noteSub = _note.listen((note) {
      if (Helper.saveNote(note)) {
        _firestoreService.saveNote(note);
      } else {
        deleteNote(note);
      }
    });

    Note note = Get.arguments;
    if (note != null) {
      _titleController.text = note.title;
      _desController.text = note.description;
      _note(note);
    }
    super.onReady();
  }

  @override
  void onClose() {
    _titleController?.dispose();
    _desController?.dispose();
    _noteSub?.cancel();
    super.onClose();
  }

  Future pickImage() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);
    if (pickedFile != null) {
      var file = File(pickedFile.path);
      final ext = p.extension(pickedFile.path);
      final name = p.basenameWithoutExtension(pickedFile.path);
      final appDir = await getApplicationDocumentsDirectory();
      final File newImage = await file.copy('${appDir.path}/$name$ext');
      _note(_note.value.copyWith(
          image: newImage.path,
          editedAt: DateTime.now().millisecondsSinceEpoch));
    }
  }

  onDeleteNote() {
    deleteNote(_note.value);
    Get.until((route) => Get.currentRoute == '/home');
  }

  onRemoveImage() {
    var imagePath = _note.value.image;
    if (!["", null].contains(imagePath)) {
      if (Uri.parse(imagePath).isAbsolute)
        _cloudStorageService.deleteImage(_note.value);
      else
        File(imagePath).delete();
    }
    _note(_note.value.copyWith(image: ""));
  }

  setTitle(String title) {
    var note = _note.value.copyWith(
        title: title, editedAt: DateTime.now().millisecondsSinceEpoch);
    _note(note);
  }

  setDescription(String des) {
    var note = _note.value.copyWith(
        description: des, editedAt: DateTime.now().millisecondsSinceEpoch);
    _note(note);
  }

  void deleteNote(Note note) {
    _firestoreService.deleteNote(note);
    _cloudStorageService.deleteImage(note);
  }
}
