import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../stripe/model/paymant_model.dart';

class PymantItemSelected extends StatelessWidget {
  PymantItemSelected({
    required this.isActive,
    required this.paymantModel,
    super.key,
  });
  bool isActive;
  PaymantMethodModel paymantModel;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 800),
      width: 103,
      height: 62,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.50, color: isActive ? Color(0xFF34A853) : Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: isActive ? Color(0xFF34A853) : Colors.white,
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: SvgPicture.asset(
          paymantModel.image,
        ),
      ),
    );
  }
}
