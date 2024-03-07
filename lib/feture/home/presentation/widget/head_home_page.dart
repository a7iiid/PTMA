import 'package:flutter/material.dart';
import 'package:ptma/shapes/home_screen.dart';

class HeadHomePage extends StatelessWidget {
  const HeadHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.sizeOf(context).width,
          (MediaQuery.sizeOf(context).width * 0.7433155080213903).toDouble()),
      painter: RPSCustomPainter(),
    );
  }
}
