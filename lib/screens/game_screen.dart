// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:hang_man/Theme/theme.dart';
import 'package:hang_man/apis/random_word_api.dart';
import 'package:hang_man/extensions/context_extension.dart';
import 'package:hang_man/logger.dart';
import 'package:hang_man/provider/screen_size.dart';
import 'package:hang_man/screens/result_screen.dart';
import 'package:hang_man/utils/Game%20Screen/words.dart';
import 'package:provider/provider.dart';

import '../provider/game_provider.dart';
import '../utils/Game Screen/rope.dart';
import '../utils/Game Screen/score_.dart';
import '../utils/Game Screen/stick_man.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late double w;
  late double h;
  final PageController _controller = PageController();
  @override
  void initState() {
    super.initState();

    /// Reset the game data.
    Provider.of<Game>(context, listen: false).reset();
    Provider.of<WordProvider>(context, listen: false).reset(resScore: true);

    w = Provider.of<ScreenSize>(context, listen: false).screenWidth;
    h = Provider.of<ScreenSize>(context, listen: false).screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    // logger.i("Game Screen");
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Word 1"),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const EndScreen(),
              ),
            ),
            child: Text(
              "End",
              style: context.textTheme.labelLarge,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            //* Skor  [Text] Fade
            const Positioned(
              top: 16,
              left: 16,
              child: Score(),
            ),

            /// @[Rope] , [StickMan] , and [Words] section
            PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              onPageChanged: (value) async {},
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 500,
                  width: 500,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      //* Rope Centered
                      Positioned(
                        left: (w - (w / 2)) / 2,
                        top: 0,
                        child: Rope(
                          screenHeight: h,
                          screenWidth: w,
                        ),
                      ),
                      //* Stickman Parts
                      Positioned(
                        top: h * 0.25,
                        left: (w - w / 2) / 2,
                        child: StickMan(
                          screenHeight: h,
                          screenWidth: w,
                        ),
                      ),
                      //* Words
                      Positioned(
                        top: h * 0.5,
                        child: Words(
                          screenHeight: h,
                          screenWidth: w,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            /// Pass Button
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<WordProvider>(
                  builder: (context, value, child) {
                    logger.i(value.word);
                    if (value.trueCount == value.word.length &&
                        value.word.isNotEmpty) {
                      return ElevatedButton(
                        style: context.theme.elevatedButtonTheme.style!
                            .copyWith(
                                fixedSize: MaterialStatePropertyAll(
                                  Size(
                                    w * 0.8,
                                    50,
                                  ),
                                ),
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColors.greenColor)),
                        onPressed: () {
                          logger.i("Word : " + value.word);
                          logger
                              .i("true Count : " + value.trueCount.toString());
                          _controller.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.bounceIn);
                        },
                        child: const Text("Continue"),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        /// Pass Button
                        ElevatedButton(
                          style:
                              context.theme.elevatedButtonTheme.style!.copyWith(
                            fixedSize: MaterialStatePropertyAll(
                              Size(
                                w * 0.4,
                                50,
                              ),
                            ),
                          ),
                          child: const Text("Pass"),
                          onPressed: () => _controller.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.bounceIn),
                        ),

                        /// Hint Button
                        ElevatedButton(
                          style:
                              context.theme.elevatedButtonTheme.style!.copyWith(
                            fixedSize: MaterialStatePropertyAll(
                              Size(
                                w * 0.4,
                                50,
                              ),
                            ),
                          ),
                          child: const Text("Hint"),
                          onPressed: () =>
                              Provider.of<WordProvider>(context, listen: false)
                                  .showHint(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Container(
//   height: 200,
//   child: AlignTransition(
//     alignment: _aligmentAnimation,
//     child: RotationTransition(
//       turns: _rotationAnimation,
//       child: Container(
//         width: 100,
//         height: 100,
//         color: Colors.black.withOpacity(0.1),
//       ),
//     ),
//   ),
// );

// TweenAnimationBuilder(
//   duration: Duration(seconds: 3),
//   tween: Tween(begin: 0.0, end: context.width * 0.5),
//   builder: (BuildContext context, double? value, Widget? child) =>
//       Positioned(
//     left: value,
//     top: context.height * 0.4,
//     child: Text("asd"),
//   ),
//   onEnd: () => setState(() {
//     logger.i("message");
//     val = 0;
//   }),
// );

// AnimatedBuilder(
//   animation: _animation,
//   child: Container(
//     color: Colors.blue,
//     width: 150,
//     height: 150,
//   ),
//   builder: (context, child) {
//     return Opacity(
//       opacity: _animation.value,
//       child: child!,
//     );
//   },
// );
