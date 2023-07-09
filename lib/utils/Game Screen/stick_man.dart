import 'package:flutter/material.dart';
import 'package:hang_man/extensions/context_extension.dart';
import 'package:hang_man/logger.dart';
import 'package:hang_man/provider/game_provider.dart';
import 'package:provider/provider.dart';

import 'draw_stick_man.dart';

class StickMan extends StatefulWidget {
  const StickMan({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  State<StickMan> createState() => _StickManState();
}

class _StickManState extends State<StickMan>
    with SingleTickerProviderStateMixin {
  final List<FadeTransition> _bodyPart = [];

  late final Animation<double> _animation;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    Provider.of<Game>(context, listen: false).resetBodyParts();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.i("Stick MAn");

    final double w = widget.screenWidth;
    final double h = widget.screenHeight;
    return SizedBox(
      // color: Colors.red,
      width: w / 2,
      height: h * 0.35,
      child: Consumer<Game>(
        builder: (context, value, child) {
          //FIXME:
          _controller.reset();
          _controller.forward();
          if (value.bodyParts.isEmpty) {
            return const SizedBox();
          }
          _bodyPart.add(
            FadeTransition(
              opacity: _animation,
              child: CustomPaint(
                painter: DrawStickMan(
                  bodyParts: value.bodyParts.last,
                ),
                size: Size(w, h),
              ),
            ),
          );
          return Stack(
            children: [..._bodyPart.map((e) => e)],
          );
        },
      ),
    );
  }
}
