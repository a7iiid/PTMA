import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/rout.dart';
import '../../../../../core/widget/custom_button.dart';
import 'head_home_page.dart';

class SelectRouts extends StatelessWidget {
  const SelectRouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const HeadHomePage(),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20),
                  child: SvgPicture.asset(Assets.imagesMenuIcon),
                ),
                Positioned(
                  bottom: -MediaQuery.sizeOf(context).height * .22,
                  left: 40,
                  right: 40,
                  child: Container(
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        color: Colors.amber),
                    height: MediaQuery.sizeOf(context).height * .45,
                    width: MediaQuery.sizeOf(context).width * .7,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .30,
            ),
          ],
        ),
      ),
    );
  }
}
