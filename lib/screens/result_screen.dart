import 'package:flutter/material.dart';
import 'package:hang_man/apis/random_word_api.dart';
import 'package:provider/provider.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          Provider.of<WordProvider>(context).score.toString(),
        ),
      ),
    );
  }
}
