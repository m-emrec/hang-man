import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hang_man/apis/random_word_api.dart';
import 'package:hang_man/extensions/context_extension.dart';
import 'package:hang_man/provider/game_provider.dart';
import 'package:provider/provider.dart';

import '../../Theme/theme.dart';
import '../../logger.dart';
import 'char_card.dart';

class Words extends StatefulWidget {
  const Words(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.controller});
  final double screenWidth;
  final double screenHeight;
  final PageController controller;
  @override
  State<Words> createState() => _WordsState();
}

class _WordsState extends State<Words> {
  late String word;
  late String def;

  List get getChars {
    List chars = [];
    for (var i = 0; i < word.length; i++) {
      chars.add(word[i]);
    }
    return chars;
  }

  late int visibleCharCount;
  late int visibleCharIndex;
  late int charIndex;
  @override
  void initState() {
    super.initState();
    // Provider.of<WordProvider>(context, listen: false).randomWord();
    Provider.of<WordProvider>(context, listen: false).reset();
  }

  @override
  Widget build(BuildContext context) {
    logger.i("Words Built");
    return SizedBox(
      width: widget.screenWidth,
      height: widget.screenHeight * 0.3,
      child: FutureBuilder(
        future: Provider.of<WordProvider>(context, listen: false).randomWord(),
        // initialData:
        //     Provider.of<WordProvider>(context, listen: false).randomWord(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return build(context);
            }
            charIndex = 0;
            word = snapshot.data["word"];
            def = snapshot.data["def"];
            logger.i("Word : $word");
            return Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    ...getChars.map(
                      (char) {
                        charIndex++;

                        final ValueKey key = ValueKey(charIndex - 1);
                        return CharCard(
                          key: key,
                          char: char,
                          visible: false,
                          index: charIndex - 1,
                        );
                      },
                    ),
                  ],
                ),

                /// Definition
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: widget.screenHeight * 0.1,
                      child: Text(def),
                    ),
                  ),
                ),
                const Spacer(),

                ///  Buttons
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer<WordProvider>(
                    builder: (context, value, child) {
                      logger.i(value.word);
                      if (value.trueCount + value.hintCount ==
                              value.word.length &&
                          value.word.isNotEmpty) {
                        return ElevatedButton(
                          style: context.theme.elevatedButtonTheme.style!
                              .copyWith(
                                  fixedSize: MaterialStatePropertyAll(
                                    Size(
                                      widget.screenWidth * 0.8,
                                      50,
                                    ),
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColors.greenColor)),
                          onPressed: () {
                            widget.controller.nextPage(
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
                            style: context.theme.elevatedButtonTheme.style!
                                .copyWith(
                              fixedSize: MaterialStatePropertyAll(
                                Size(
                                  widget.screenWidth * 0.4,
                                  50,
                                ),
                              ),
                            ),
                            child: const Text("Pass"),
                            onPressed: () => widget.controller.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.bounceIn),
                          ),

                          /// Hint Button
                          ElevatedButton(
                            style: context.theme.elevatedButtonTheme.style!
                                .copyWith(
                              fixedSize: MaterialStatePropertyAll(
                                Size(
                                  widget.screenWidth * 0.4,
                                  50,
                                ),
                              ),
                            ),
                            child: const Text("Hint"),
                            onPressed: () => Provider.of<WordProvider>(context,
                                    listen: false)
                                .showHint(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

/*




*/