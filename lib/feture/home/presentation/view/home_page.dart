import 'package:flutter/material.dart';
import 'package:ptma/shapes/home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        size: Size(
            MediaQuery.sizeOf(context).width,
            (MediaQuery.sizeOf(context).width * 0.7433155080213903)
                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
        painter: RPSCustomPainter(),
      ),
    );
  }
}
