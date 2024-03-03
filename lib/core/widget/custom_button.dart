import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ptma/core/utils/Style.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key, required this.title,
      this.backgraondColor = const Color(0xff4960F9),
      this.textStyle = AppStyle.reguler20prime,
      this.iconcolor = Colors.white,
      required this.function});

  Color backgraondColor;
  final title;
  final textStyle;
  final iconcolor;
  final function;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        height: 72,
        child: ElevatedButton(
          onPressed: function,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xff667eea), Color(0xff64b6ff)]),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              constraints: const BoxConstraints.expand(),
              child: Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: textStyle,
                  ),
                  const Spacer(),
                  Transform.rotate(
                    angle: pi,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: iconcolor,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
