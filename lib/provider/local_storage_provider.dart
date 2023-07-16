import 'package:flutter/material.dart';
import 'package:hang_man/logger.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends ChangeNotifier {
  Future<SharedPreferences> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs;
  }

  Future saveScore(int score) async {
    SharedPreferences prefs = await getPrefs();

    final DateTime date = DateTime.now();

    final String dateString = DateFormat.yMMMMd().format(date);

    /// if there is data then add new score to List
    if (prefs.containsKey("Score")) {
      final List<String>? scoreList = prefs.getStringList("Score");
      final List<String>? dateList = prefs.getStringList("Date");

      /// if the score is different then add the score to the list
      if (!scoreList!.contains(score.toString()) && score != 0) {
        scoreList.add(score.toString());
        dateList!.add(dateString);

        prefs.setStringList("Score", scoreList);
        prefs.setStringList("Date", dateList);
      }
    } else {
      /// if there is no data create new List
      prefs.setStringList("Score", [score.toString()]);
      prefs.setStringList("Date", [dateString]);
    }
  }

  getScore() async {
    SharedPreferences prefs = await getPrefs();
    List<String> scoreList = prefs.getStringList("Score") ?? [];
    List<String> dateList = prefs.getStringList("Date") ?? [];

    final Map data = {
      "score": scoreList,
      "date": dateList,
    };

    return data;
  }

  saveSettings() {}

  ////
}
