import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app_binding.dart';
import 'package:stack_fin_notes/app_routes.dart';
import 'app/core/translations/app_translations.dart';
import 'app/core/theme/app_theme.dart';

Future<void> main() async {
  await init();
  runApp(
    GetMaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      enableLog: true,
      locale: Locale('en', 'US'),
      translationsKeys: AppTranslation.translations,
      getPages: AppRoutes.pages,
      initialRoute: '/home',
      theme: AppTheme.getTheme(),
      initialBinding: AppBinding(),
    ),
  );
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
