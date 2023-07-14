import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hang_man/logger.dart';
import 'package:hang_man/provider/game_provider.dart';
import 'package:http/http.dart' as http;

/// https://api-ninjas.com/api/randomword
///
///
///
///
///
class WordProvider extends Game {
  String _word = "";
  String get word => _word;
  String? _def = "";
  String? get def => _def;
  int _trueCount = 0;
  int get trueCount => _trueCount;

  List<int> hintIndexList = [];

  // ignore: constant_identifier_names
  static const _API_KEY = "3QiuXduPluL6XSoZaJ/LjA==wu6tKTBupAQ6KLxs";

  @override
  reset({bool resScore = false}) {
    _word = "";
    _def = "";
    _trueCount = 0;
    resScore ? score = 0 : null;
    hintIndexList.clear();
    notifyListeners();
  }

  /// Get a random word from the API.
  Future randomWord() async {
    var url = Uri.parse("https://api.api-ninjas.com/v1/randomword");

    var wordRes = await http.get(url, headers: {'X-Api-Key': _API_KEY});

    if (wordRes.statusCode == 200) {
      _word = jsonDecode(wordRes.body)["word"];
      _def = await dictionary(_word);

      /// if the word doesn't have a definition then run the function again.
      if (_def == null) {
        await randomWord();
      } else {
        /// if it has a definition set the [def].
        // Some words have more than one definition that's why I split the definition.
        _def = _def!.split("2.")[0];

        final Map data = {
          "word": word,
          "def": def,
        };
        notifyListeners();
        return data;
      }
    }
  }

  Future<String?> dictionary(String word) async {
    var url = Uri.parse("https://api.api-ninjas.com/v1/dictionary?word=$_word");

    var res = await http.get(url, headers: {'X-Api-Key': _API_KEY});

    if (res.statusCode == 200) {
      /// if [word] has a definition return it.
      if (jsonDecode(res.body)["valid"]) {
        return jsonDecode(res.body)["definition"];
      }
    }

    /// else return null.
    return null;
  }

  void a() {
    if (_trueCount == word.length) {
      logger.e("message");
      final int point = word.length * 2;
      // Provider.of<Game>(ctx, listen: false).increaseScore(point);
      increaseScore(point);
    }
  }

  bool checkChar(BuildContext ctx, String char, int index) {
    /// if the [char] which the user wrote is correct , return true.
    if (_word[index].toLowerCase() == char.toLowerCase()) {
      _trueCount++;
      hintIndexList.add(index);
      a();
      return true;
    } else {
      return false;
    }
  }

  @override
  void showHint() {
    logger.i("Show Hint called");

    int hintIndex = Random().nextInt(word.length);

    while (true) {
      /// if [hintIndexList] contains the [hintIndex]
      /// and the length of the list smaller than the word's length
      /// continue the loop , until new index found.
      if (hintIndexList.length < word.length) {
        if (hintIndexList.contains(hintIndex)) {
          hintIndex = Random().nextInt(word.length);
        } else {
          /// if the the [hintIndex] is new then break the loop
          hintIndexList.add(hintIndex);
          increaseScore(-2);
          _trueCount++;
          a();
          notifyListeners();

          break;
        }
      } else {
        break;
      }
    }
    super.showHint();
  }
}
