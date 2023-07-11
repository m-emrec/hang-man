import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hang_man/apis/random_word_api.dart';
import 'package:provider/provider.dart';

import '../../logger.dart';
import 'char_card.dart';

class Words extends StatefulWidget {
  const Words(
      {super.key, required this.screenWidth, required this.screenHeight});
  final double screenWidth;
  final double screenHeight;
  @override
  State<Words> createState() => _WordsState();
}

class _WordsState extends State<Words> {
  late String word;

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

    visibleCharCount = Random().nextInt(3);
  }

  @override
  Widget build(BuildContext context) {
    logger.i("Words");
    charIndex = 0;
    return SizedBox(
      width: widget.screenWidth,
      child: FutureBuilder(
        future: Provider.of<WordProvider>(context, listen: false).randomWord(),
        // initialData:
        //     Provider.of<WordProvider>(context, listen: false).randomWord(),
        builder: (context, snapshot) {
          return Consumer<WordProvider>(
            builder: (context, value, child) {
              word = value.word;

              if (snapshot.connectionState == ConnectionState.done) {
                // logger.e(snapshot.data);
                // logger.e(snapshot.data);
                if (snapshot.data == null) {
                  return build(context);
                }
                logger.i("Word : $word");
                return Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        ...getChars.map(
                          (char) {
                            //FIXME:
                            charIndex++;
                            visibleCharIndex =
                                Random(charIndex).nextInt(getChars.length);
                            if (charIndex - 1 == visibleCharIndex &&
                                charIndex - 1 < visibleCharCount) {
                              return CharCard(
                                char: char,
                                visible: true,
                                index: charIndex - 1,
                              );
                            }
                            return CharCard(
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: widget.screenHeight * 0.1,
                          child: Text(value.def ?? ""),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}

/*




*/