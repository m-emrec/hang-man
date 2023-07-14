import 'package:flutter/material.dart';
import 'package:hang_man/Theme/theme.dart';
import 'package:hang_man/extensions/context_extension.dart';
import 'package:hang_man/extensions/empty_padding_extension.dart';
import 'package:hang_man/provider/screen_size.dart';
import 'package:hang_man/screens/game_screen.dart';
import 'package:hang_man/utils/HomePage/hangman.dart';
import 'package:hang_man/utils/shared/myButton.dart';
import 'package:provider/provider.dart';

import '../provider/game_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<Game>(context, listen: false).reset();
  }

  @override
  Widget build(BuildContext context) {
    final double h = context.mediaQuery.size.height;
    final double w = context.mediaQuery.size.width;
    Provider.of<ScreenSize>(context).changeSize(w, h);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hangman",
          style: TextStyle(color: AppColors.buttonColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            /// Hangman Animation
            const Expanded(
              child: HangMan(),
            ),

            /// Start Button -> Navigates to [GamePage]
            MyButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const GamePage(),
                ),
              ),
              child: Text(
                "Start",
                style: context.textTheme.labelMedium,
              ),
            ),

            /// Some padding
            (h * 0.05).ph,
          ],
        ),
      ),
    );
  }
}
