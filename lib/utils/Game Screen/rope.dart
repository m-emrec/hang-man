import 'package:flutter/material.dart';
import 'package:hang_man/extensions/context_extension.dart';
import 'package:hang_man/extensions/img_extension.dart';
import 'package:hang_man/logger.dart';
import 'package:hang_man/provider/game_provider.dart';
import 'package:hang_man/screens/result_screen.dart';
import 'package:provider/provider.dart';

class Rope extends StatefulWidget {
  const Rope(
      {super.key, required this.screenHeight, required this.screenWidth});
  final double screenHeight;
  final double screenWidth;
  @override
  State<Rope> createState() => _RopeState();
}

class _RopeState extends State<Rope> with TickerProviderStateMixin {
  late final AnimationController _ropeAnimationController;
  late final AnimationController _endGameController;
  late final Animation<double> _ropeAnimation;
  late final Animation<double> _endGameAnimation;
  late double screenHeight;
  late double screenWidth;

  @override
  void initState() {
    super.initState();

    screenHeight = widget.screenHeight;
    screenWidth = widget.screenWidth;
    _ropeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    _endGameController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _ropeAnimation = Tween(begin: 0.0, end: screenHeight * 0.2)
        .animate(_ropeAnimationController);

    _endGameAnimation =
        Tween(end: 0.0, begin: screenHeight * 0.28).animate(_endGameController);

    _endGameController.addStatusListener(_statusListener);
  }

  @override
  void dispose() {
    _ropeAnimationController.dispose();
    _endGameController.removeStatusListener(_statusListener);
    _endGameController.dispose();

    super.dispose();
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      logger.i("message");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const EndScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.i("Rope");
    // final double w = context.width;

    return Consumer<Game>(
      builder: (context, value, child) {
        /// When the endGameAnimation ended navigate to @[EndScreen]

        /// if the user is dead then run the [@_endGameAnimation]
        if (value.isDead) {
          _endGameController.forward();
        }
        return AnimatedBuilder(
          animation: value.isDead ? _endGameAnimation : _ropeAnimation,
          builder: (context, Widget? child) {
            return SizedBox(
              height:
                  value.isDead ? _endGameAnimation.value : _ropeAnimation.value,
              width: screenWidth / 2,
              child: Image.asset(
                "rope".toPng,
                fit: BoxFit.fitHeight,
              ),
            );
          },
        );
      },
    );
  }
}
