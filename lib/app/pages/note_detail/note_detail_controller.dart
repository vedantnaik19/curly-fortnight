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
import 'package:path/path.dart' as p;
import 'package:stack_fin_notes/app/utils/helper.dart';
import 'package:stack_fin_notes/app_controller.dart';

/// Controller
class NoteDetailController extends GetxController {
  final AppController _appController = Get.find();
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
    try {
      final pickedFile = await ImagePicker().getImage(
          source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);
      if (pickedFile != null) {
        var file = File(pickedFile.path);
        final ext = p.extension(pickedFile.path);
        final appDir = await getApplicationDocumentsDirectory();
        final File newImage =
            await file.copy('${appDir.path}/image_${note.value.id}$ext');
        _note(_note.value.copyWith(
            image: newImage.path,
            editedAt: DateTime.now().millisecondsSinceEpoch));
      }
    } catch (e) {
      handleError(e);
    }
  }

  onDeleteNote() {
    deleteNote(_note.value);
    Get.until((route) => Get.currentRoute == '/home');
  }

  onRemoveImage() {
    try {
      var imagePath = _note.value.image;
      if (!["", null].contains(imagePath)) {
        if (Uri.parse(imagePath).isAbsolute)
          _cloudStorageService.deleteImage(_note.value);
        else
          File(imagePath).delete();
      }
      _note(_note.value.copyWith(image: ""));
    } catch (e) {
      handleError(e, "Failed to remove image.");
    }
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
    try {
      _firestoreService.deleteNote(note);
      _cloudStorageService.deleteImage(note);
    } catch (e) {
      handleError(e, "Failed to delete note.");
    }
  }

  void handleError(e, [String message]) {
    GetUtils.printFunction("NoteDetailController: ", e, message);
    var erroString = e.toString().toLowerCase();
    if (erroString.contains('network'))
      message = "Please check your internet connection and try again!";
    else if (erroString.contains('photo_access_denied'))
      message = "Please grant permission to access gallery";
    _appController.showSnack(message ?? e.message ?? e.toString());
  }
}
