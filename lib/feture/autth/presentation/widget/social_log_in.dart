import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';

class SocialLogIn extends StatelessWidget {
  const SocialLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Or continue with'.tr(context),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF1F41BB),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 44,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: ShapeDecoration(
                    color: Color(0xFFEBEBEB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: SvgPicture.asset(Assets.imagesGoogleLogo)),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 44,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: ShapeDecoration(
                    color: Color(0xFFEBEBEB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: SvgPicture.asset(Assets.imagesFacebookLogo)),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 44,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: ShapeDecoration(
                    color: Color(0xFFEBEBEB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: SvgPicture.asset(Assets.imagesAppleLogo)),
            ],
          ),
        ],
      ),
    );
  }
}
