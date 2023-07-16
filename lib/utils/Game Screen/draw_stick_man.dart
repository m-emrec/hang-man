import 'package:flutter/material.dart';
import 'package:hang_man/enums/stic_man_body_parts.dart';
import 'package:hang_man/extensions/context_extension.dart';

class DrawStickMan extends CustomPainter {
  final StickmanBodyParts bodyParts;
  final BuildContext context;

  DrawStickMan(
    this.context, {
    required this.bodyParts,
  });

  late Paint _paint;
  void drawHead(Canvas canvas, Size size, Offset headDistance) {
    double headSize = 30;
    double eyeSize = 3;

    ///
    Offset leftEyeDistance = Offset(
      headDistance.dx * 0.85,
      headDistance.dy * 0.85,
    );

    ///
    Offset rigthEyeDistance = Offset(
      headDistance.dx * 1.15,
      headDistance.dy * 0.85,
    );

    ///
    Offset sMouthDistance = Offset(
      headDistance.dx * 0.88,
      headDistance.dy * 1.5,
    );

    ///
    Offset eMouthDistance = Offset(
      headDistance.dx * 1.12,
      headDistance.dy * 1.5,
    );

    /// head
    canvas.drawCircle(
        headDistance, headSize, _paint..style = PaintingStyle.stroke);

    /// left eye
    canvas.drawCircle(
      leftEyeDistance,
      eyeSize,
      _paint
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke,
    );

    /// right eye
    canvas.drawCircle(
      rigthEyeDistance,
      eyeSize,
      _paint
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke,
    );

    /// Mouth
    canvas.drawLine(
      sMouthDistance,
      eMouthDistance,
      _paint,
    );
  }

  void drawBody(Canvas canvas, Size size, Offset headDistance) {
    canvas.drawLine(
      Offset(headDistance.dx, headDistance.dy * 1.8),
      Offset(headDistance.dx, headDistance.dy * 4.5),
      _paint..strokeWidth = 4,
    );
  }

  drawLeftArm(Canvas canvas, Size size, Offset headDistance) {
    /// Left Arm
    ///
    canvas.drawLine(
      Offset(headDistance.dx, headDistance.dy * 2.2),
      Offset(headDistance.dx * 0.5, headDistance.dy * 3),
      _paint..strokeWidth = 4,
    );
  }

  drawRightArm(Canvas canvas, Size size, Offset headDistance) {
    /// Right Arm
    canvas.drawLine(
      Offset(headDistance.dx, headDistance.dy * 2.2),
      Offset(headDistance.dx * 1.5, headDistance.dy * 3),
      _paint..strokeWidth = 4,
    );
  }

  void drawLeftLeg(Canvas canvas, Size size, Offset headDistance) {
    /// LEft Leg
    canvas.drawLine(
      Offset(headDistance.dx, headDistance.dy * 4.5),
      Offset(headDistance.dx * 0.5, headDistance.dy * 5.8),
      _paint..strokeWidth = 4,
    );
  }

  void drawRightLeg(Canvas canvas, Size size, Offset headDistance) {
    /// LEft Leg
    canvas.drawLine(
      Offset(headDistance.dx, headDistance.dy * 4.5),
      Offset(headDistance.dx * 1.5, headDistance.dy * 5.8),
      _paint..strokeWidth = 4,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paint = Paint()
      ..color = context.theme.brightness == Brightness.light
          ? Colors.black
          : Colors.white70
      ..strokeWidth = 4;

    Offset headDistance = Offset(size.width * 0.5, size.height * 0.12);

    switch (bodyParts) {
      case StickmanBodyParts.head:
        drawHead(canvas, size, headDistance);

        break;
      case StickmanBodyParts.body:
        drawBody(canvas, size, headDistance);

        break;
      case StickmanBodyParts.leftArm:
        drawLeftArm(canvas, size, headDistance);

        break;
      case StickmanBodyParts.rightArm:
        drawRightArm(canvas, size, headDistance);

        break;
      case StickmanBodyParts.rightLeg:
        drawLeftLeg(canvas, size, headDistance);

        break;
      case StickmanBodyParts.leftLeg:
        drawRightLeg(canvas, size, headDistance);

        break;

      default:
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
