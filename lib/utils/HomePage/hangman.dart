import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hang_man/extensions/context_extension.dart';
import 'package:hang_man/extensions/img_extension.dart';
import 'package:lottie/lottie.dart';

import '../shared/bottom_menu.dart';

class HangMan extends StatefulWidget {
  const HangMan({super.key});

  @override
  State<HangMan> createState() => _HangManState();
}

class _HangManState extends State<HangMan> with TickerProviderStateMixin {
  late final AnimationController _manAnimationController;
  late final AnimationController _ropeAnimationController;

  late final Animation<double> ropeAnimation;

  @override
  void initState() {
    super.initState();

    /// controls the StickMan's animation.
    _manAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    /// controls the Rope's animation
    _ropeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    ropeAnimation =
        Tween(begin: 0.0, end: 250.0).animate(_ropeAnimationController);

    _ropeAnimationController.forward();
    _manAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _manAnimationController.dispose();
    _ropeAnimationController.dispose();
    ropeAnimation.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    ropeAnimation.addListener(() {
      setState(() {});
    });
    final double w = context.mediaQuery.size.width;
    final double h = context.mediaQuery.size.height;
    return Stack(
      children: [
        /// Settings button.
        Positioned(
          right: 8,
          child: IconButton(
            onPressed: () => showCupertinoModalPopup(
              context: context,
              builder: (_) => const BottomMenu(),
            ),
            icon: const Icon(Icons.settings),
          ),
        ),

        /// Rope
        Positioned(
          left: (w - (w / 2)) / 2,
          top: 0,
          child: AnimatedContainer(
            width: w / 2,
            height: ropeAnimation.value,
            duration: _ropeAnimationController.duration!,
            child: Image.asset("rope".toPng),
          ),
        ),

        /// Stick Man
        Positioned(
          top: (h - h / 2) / 2,
          left: (w - w) / 2,
          child: Container(
            child: Lottie.network(
              "https://assets1.lottiefiles.com/packages/lf20_yp8zf4am/man.json",
              controller: _manAnimationController,
              width: w,
              height: h / 2,
              fit: BoxFit.fill,
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    );
  }
}
