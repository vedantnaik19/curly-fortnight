import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app_binding.dart';
import 'package:stack_fin_notes/app_routes.dart';
import 'app/core/translations/app_translations.dart';
import 'app/core/theme/app_theme.dart';
import 'app_controller.dart';

Future<void> main() async {
  final AppController appController = Get.put(AppController());
  await appController.init();
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
