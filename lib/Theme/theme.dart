import 'package:flutter/material.dart';

class AppTheme with AppColorsDark, AppColorsLight {
  /// Light Theme
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: AppColorsLight.canvasColor,

    ////           Button Themes
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColorsLight.buttonColor),
      ),
    ),
    ////

    ////        Widget Themes
    appBarTheme: const AppBarTheme(
      color: AppColorsLight.canvasColor,
      foregroundColor: AppColorsLight.buttonColor,
      centerTitle: true,
    ),
    cardTheme: const CardTheme(
      color: AppColorsLight.cardColor,
    ),
    dividerTheme: const DividerThemeData(
      endIndent: 32,
      indent: 32,
      thickness: 3,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: AppColorsLight.buttonColor,
      color: AppColorsLight.cardColor,
    ),
    ////

    ////                 Text Theme
    textTheme: const TextTheme(
      labelMedium: AppTextsLight.labelMedium,
      labelLarge: AppTextsLight.labelLarge,
      titleLarge: AppTextsLight.titleLarge,
    ),

    ////
  );

  ///*               Dark Theme
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    canvasColor: AppColorsDark.canvasColor,

    ////           Button Themes
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColorsDark.buttonColor),
      ),
    ),
    ////

    ////        Widget Themes
    appBarTheme: const AppBarTheme(
      color: AppColorsDark.canvasColor,
      foregroundColor: AppColorsDark.buttonColor,
      centerTitle: true,
    ),

    cardTheme: const CardTheme(
      color: AppColorsDark.cardColor,
    ),

    dividerTheme: const DividerThemeData(
      endIndent: 32,
      indent: 32,
      thickness: 3,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: AppColorsDark.buttonColor,
      color: AppColorsDark.cardColor,
    ),
    ////

    ////                 Text Theme
    textTheme: const TextTheme(
      labelMedium: AppTextsDark.labelMedium,
      labelLarge: AppTextsDark.labelLarge,
      titleLarge: AppTextsDark.titleLarge,
    ),

    ////
  );
}

mixin AppColorsLight {
  static const Color canvasColor = Color(0xFFFAF7F9);
  static const Color buttonColor = Color(0xFF52424D);
  static const Color cardColor = Color(0xFFFFF1D5);

  static Color greenColor = Colors.green.shade900;

  // * Text Colors
  static const Color labelColor = Color(0xFFFFF1D5);
}

mixin AppColorsDark {
  static const Color canvasColor = Color(0xFF1E1B18);
  static const Color buttonColor = Color(0xFF717c89);
  static const Color cardColor = Color(0xFF973F0C);

  static Color greenColor = Colors.green.shade900;

  // * Text Colors
  static const Color labelColor = Color(0xFFFFF1D5);
}

class AppTextsLight {
  /// Mostly used for buttons
  static const TextStyle labelMedium = TextStyle(
    color: AppColorsLight.labelColor,
  );
  static const TextStyle labelLarge = TextStyle(
    color: AppColorsLight.buttonColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleLarge = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}

class AppTextsDark {
  /// Mostly used for buttons
  static const TextStyle labelMedium = TextStyle(
    color: AppColorsDark.labelColor,
  );
  static const TextStyle labelLarge = TextStyle(
    color: AppColorsDark.labelColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleLarge = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}
