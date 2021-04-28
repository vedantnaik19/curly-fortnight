import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stack_fin_notes/app/core/constants/app_constants.dart';

class AppController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  /// Initializing essential services
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await initHive();
  }

  initHive() async {
    final document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    await Hive.openLazyBox(AppContants.NOTES_BOX);
  }
}
