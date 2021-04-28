import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stack_fin_notes/app/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData getTheme() {
    final ThemeData base = ThemeData.light();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: base.scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    return ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
        textTheme: GoogleFonts.latoTextTheme(base.textTheme).copyWith(
          headline6:
              GoogleFonts.montserrat().copyWith(fontWeight: FontWeight.w500),
        ),
        iconTheme: IconThemeData(color: Colors.black54),
        cardTheme: base.cardTheme.copyWith(
          elevation: 0.1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: AppColors.greyLight, width: 0.5)),
        ),
        appBarTheme: base.appBarTheme.copyWith(
          color: base.scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black54),
        ),
        inputDecorationTheme: base.inputDecorationTheme.copyWith(
          border: InputBorder.none,
        ),
        buttonTheme: base.buttonTheme.copyWith(colorScheme: ColorScheme.dark()),
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black));
  }
}
