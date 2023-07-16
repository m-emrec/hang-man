import 'package:flutter/material.dart';

class AppTheme {
  /// Colors

  /// Light Theme
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: AppColors.canvasColor,

    ////           Button Themes
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColors.buttonColor),
      ),
    ),
    ////

    ////        Widget Themes
    appBarTheme: const AppBarTheme(
      color: AppColors.canvasColor,
      foregroundColor: AppColors.buttonColor,
      centerTitle: true,
    ),
    cardTheme: const CardTheme(
      color: AppColors.cardColor,
    ),
    dividerTheme: const DividerThemeData(
      endIndent: 32,
      indent: 32,
      thickness: 3,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: AppColors.buttonColor,
      color: AppColors.cardColor,
    ),
    ////

    ////                 Text Theme
    textTheme: const TextTheme(
      labelMedium: AppTexts.labelMedium,
      labelLarge: AppTexts.labelLarge,
      titleLarge: AppTexts.titleLarge,
    ),

    ////
  );

  ///*               Dark Theme
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    canvasColor: Colors.black,
    appBarTheme: AppBarTheme(color: Colors.black),
    ////           Button Themes
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColors.buttonColor),
      ),
    ),
    ////

    ////        Widget Themes
    cardTheme: const CardTheme(
      color: AppColors.cardColor,
    ),
    dividerTheme: const DividerThemeData(
      endIndent: 32,
      indent: 32,
      thickness: 3,
    ),
    ////

    ////                 Text Theme
    textTheme: const TextTheme(
      labelMedium: AppTexts.labelMedium,
      labelLarge: AppTexts.labelLarge,
      titleLarge: AppTexts.titleLarge,
    ),
    ////
  );
}

class AppColors {
  static const Color canvasColor = Color(0xFFFAF7F9);
  static const Color buttonColor = Color(0xFF52424D);
  static const Color cardColor = Color(0xFFFFF1D5);

  static Color greenColor = Colors.green.shade900;

  // * Text Colors
  static const Color labelColor = Color(0xFFFFF1D5);
}

class AppTexts {
  /// Mostly used for buttons
  static const TextStyle labelMedium = TextStyle(
    color: AppColors.labelColor,
  );
  static const TextStyle labelLarge = TextStyle(
    color: AppColors.buttonColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleLarge = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}
