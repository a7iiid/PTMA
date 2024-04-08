import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

import '../../../../../core/utils/Style.dart';
import 'ordar_info.dart';
import 'paymant_method_info.dart';
import 'totle_prise.dart';

class infoPayment extends StatelessWidget {
  const infoPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 66.0, left: 22, right: 22),
      child: Column(
        children: [
          Text('Thank you!',
              textAlign: TextAlign.center, style: AppStyle.normal25),
          Text('Your transaction was successful',
              textAlign: TextAlign.center, style: AppStyle.regylar20),
          const SizedBox(
            height: 22,
          ),
          OrdarInfo(title: 'Date', data: '01/24/2023'),
          OrdarInfo(title: 'Time', data: '10:15 AM'),
          OrdarInfo(title: 'To', data: 'Sam Louis'),
          const Divider(
            thickness: 2,
            height: 60,
          ),
          TotlePrise(title: 'Totle', value: r'$89'),
          const SizedBox(height: 30),
          paymantMethodInfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                FontAwesomeIcons.barcode,
                size: 80,
              ),
              Container(
                width: 113,
                height: 58,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.50, color: Color(0xFF34A853)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text('PAID',
                      textAlign: TextAlign.center,
                      style:
                          AppStyle.bold24.copyWith(color: Color(0xFF34A853))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
