import 'package:flutter/material.dart';
import 'package:ptma/core/utils/shapes/drawer_shape.dart';

class ShapeOfDrawer extends StatelessWidget {
  const ShapeOfDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.sizeOf(context).width * .697,
          (MediaQuery.sizeOf(context).height * 0.7).toDouble()),
      painter: RPSCustomPainter(),
    );
  }
}
