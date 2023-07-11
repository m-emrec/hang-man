import 'package:flutter/material.dart';
import 'package:hang_man/enums/stic_man_body_parts.dart';
import 'package:hang_man/logger.dart';

class Game extends ChangeNotifier {
  List<StickmanBodyParts> _bodyParts = [];
  List get bodyParts => _bodyParts;

  bool _isDead = false;

  bool get isDead => _isDead;

  int _score = 0;
  int get score => _score;

  /// Hang the Stick Man.
  hang() {
    _isDead = true;
    notifyListeners();
  }

  /// Add body part to [bodyParts] list.
  addPart() {
    try {
      _bodyParts.add(
          StickmanBodyParts.values[_bodyParts.isEmpty ? 0 : _bodyParts.length]);

      /// if [bodyParts] length equals to StickmanBodyParts length Hang the man.
      if (_bodyParts.length == StickmanBodyParts.values.length) {
        hang();
      }
    } on RangeError catch (_) {}
    notifyListeners();
  }

  Future<void> resetBodyParts() async {
    _bodyParts = [];
    _isDead = false;
    _score = 0;
    notifyListeners();
  }

  void increaseScore(int point) {
    logger.d("İncrease Score");
    logger.i("Before :  $_score");
    _score += point;
    logger.i("Then :  $_score");
    notifyListeners();
  }
}
