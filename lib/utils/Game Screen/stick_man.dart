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
  final List _bodyPart = [];

  @override
  void initState() {
    super.initState();

    Provider.of<Game>(context, listen: false).reset();
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
          if (value.bodyParts.isEmpty) {
            return const SizedBox();
          }
          _bodyPart.add(
            CustomPaint(
              painter: DrawStickMan(
                context,
                bodyParts: value.bodyParts.last,
              ),
              size: Size(w, h),
            ),
          );
          return Stack(
            children: [
              ..._bodyPart.map((e) => e),
            ],
          );
        },
      ),
    );
  }
}
