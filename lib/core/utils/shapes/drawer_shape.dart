import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.002673797, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height * 0.6201439);
    path_0.cubicTo(
        size.width,
        size.height * 0.7531043,
        size.width,
        size.height * 0.8195863,
        size.width * 0.9807647,
        size.height * 0.8703705);
    path_0.cubicTo(
        size.width * 0.9638476,
        size.height * 0.9150432,
        size.width * 0.9368503,
        size.height * 0.9513633,
        size.width * 0.9036444,
        size.height * 0.9741223);
    path_0.cubicTo(size.width * 0.8658957, size.height, size.width * 0.8164786,
        size.height, size.width * 0.7176471, size.height);
    path_0.lineTo(size.width * 0.2796791, size.height);
    path_0.cubicTo(size.width * 0.1808463, size.height, size.width * 0.1314299,
        size.height, size.width * 0.09368075, size.height * 0.9741223);
    path_0.cubicTo(
        size.width * 0.06047567,
        size.height * 0.9513633,
        size.width * 0.03347914,
        size.height * 0.9150432,
        size.width * 0.01656035,
        size.height * 0.8703705);
    path_0.cubicTo(
        size.width * -0.002673797,
        size.height * 0.8195863,
        size.width * -0.002673797,
        size.height * 0.7531043,
        size.width * -0.002673797,
        size.height * 0.6201439);
    path_0.lineTo(size.width * -0.002673797, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * -8.021390, size.height * 0.02524629),
        Offset(size.width * 0.07921711, size.height * 1.348723),
        [Colors.white.withOpacity(.9), Colors.white.withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
