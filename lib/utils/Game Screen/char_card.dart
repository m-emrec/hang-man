import 'package:flutter/material.dart';
import 'package:hang_man/Theme/theme.dart';
import 'package:hang_man/apis/random_word_api.dart';
import 'package:hang_man/extensions/context_extension.dart';
import 'package:hang_man/logger.dart';
import 'package:provider/provider.dart';

import '../../provider/game_provider.dart';

class CharCard extends StatefulWidget {
  const CharCard({
    super.key,
    required this.char,
    this.visible,
    required this.index,
  });
  final String char;
  final bool? visible;
  final int index;
  @override
  State<CharCard> createState() => _CharCardState();
}

class _CharCardState extends State<CharCard>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();

  bool? _isTrue;

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    /// If the word is visible set [controller] text value
    _controller.text = widget.visible! ? widget.char : "";

    /// Animation controller for FadeTransition.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SizedBox(
        height: 50,
        width: 50,
        child: Card(
          /// if isTrue = null color will be cardColor.
          /// if isTrue is not null but true , color will be green
          /// if isTrue is not null but false , color will be red
          color: _isTrue == null
              ? Theme.of(context).cardColor
              : _isTrue!
                  ? AppColors.greenColor.withOpacity(0.5)
                  : Colors.red.shade900.withOpacity(0.5),
          child: TextField(
            /// if char is visible then set the TextField as readOnly
            readOnly: widget.visible!,
            controller: _controller,
            style: context.textTheme.labelLarge,
            maxLength: 1,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,

              /// just remove the maxLength text .
              counterText: "",
            ),
            textAlignVertical: TextAlignVertical.bottom,
            showCursor: false,
            onSubmitted: (value) {
              setState(() {
                _isTrue = Provider.of<WordProvider>(context, listen: false)
                    .checkChar(value, widget.index);
              });

              /// if the char is not true then call [addPart] func and clear the Card.
              if (_isTrue == false) {
                _controller.clear();
                Provider.of<Game>(context, listen: false).addPart();
              }
            },
          ),
        ),
      ),
    );
  }
}
