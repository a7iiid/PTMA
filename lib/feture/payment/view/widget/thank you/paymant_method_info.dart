import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/Style.dart';
import '../../../../../core/utils/images.dart';

class paymantMethodInfo extends StatelessWidget {
  const paymantMethodInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: ListTile(
        title: Text(
          'Credit Card',
          style: AppStyle.regylar18,
        ),
        subtitle: Text(
          'Mastercard **78 ',
          style: AppStyle.regler16,
        ),
        leading: SvgPicture.asset(Assets.imagesMastercard),
      ),
    );
  }
}
