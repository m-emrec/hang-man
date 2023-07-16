import 'package:flutter/material.dart';
import 'package:hang_man/apis/random_word_api.dart';
import 'package:hang_man/extensions/context_extension.dart';
import 'package:hang_man/logger.dart';
import 'package:hang_man/provider/game_provider.dart';
import 'package:provider/provider.dart';

class Score extends StatefulWidget {
  const Score({super.key});

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // logger.i("Skore : " + Provider.of<Game>(context).score.toString());
    return Consumer<WordProvider>(
      builder: (context, value, child) => FadeTransition(
        opacity: _controller,
        child: Text(
          "Score : ${value.score} ",
          style: context.textTheme.labelLarge!.copyWith(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
