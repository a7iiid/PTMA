import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// //Add this CustomPaint widget to the Widget Tree

// //Copy this CustomPainter code to the Bottom of the File
// class RPSCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint0Fill = Paint()..style = PaintingStyle.fill;
//     paint0Fill.shader = ui.Gradient.linear(
//         Offset(size.width * -143.9667, size.height * -69.60874),
//         Offset(size.width * 0.4409787, size.height * 0.5143252), [
//       const Color(0xff5264F9).withOpacity(1),
//       const Color(0xff64b6ff).withOpacity(1)
//     ], [
//       .8,
//       1
//     ]);

//     canvas.drawCircle(Offset(size.width * -0.3400213, size.height * 0.02483497),
//         size.width * 1.099645, paint0Fill);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * -189.4298, size.height * -93.24637),
        Offset(size.width * 0.5802351, size.height * 0.6889789), [
      const Color(0xff5264F9).withOpacity(1),
      const Color(0xff64b6ff).withOpacity(1)
    ], [
      0,
      1
    ]);
    canvas.drawCircle(Offset(size.width * -0.2, size.height * 0.003),
        size.width * 1.2, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
