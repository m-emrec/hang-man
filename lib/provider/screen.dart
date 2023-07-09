import 'package:flutter/material.dart';

class ScreenSize extends ChangeNotifier {
  double screenWidth = 0;
  double screenHeight = 0;

  changeSize(double width, double height) {
    screenWidth = width;
    screenHeight = height;
  }
}
