import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/core/widget/custom_button.dart';
import 'package:ptma/core/utils/drawer/drawer.dart';
import 'package:ptma/feture/google_map/view/homemap.dart';
import 'package:ptma/feture/home/presentation/manger/cubit/app_cubit.dart';
import 'package:ptma/feture/home/presentation/view/widget/head_home_page.dart';

import '../../../../../core/utils/rout.dart';
import 'greetingslogin.dart';

class HomeBody extends StatelessWidget {
  HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const HeadHomePage(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset(Assets.imagesMenuIcon),
                      ],
                    ),
                  ),
                ),
                const Greetingslogin(),
              ],
            ),
            Positioned(
              bottom: -MediaQuery.sizeOf(context).height * .29,
              left: 40,
              right: 40,
              child: Container(
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    color: Colors.amber),
                height: MediaQuery.sizeOf(context).height * .45,
                width: MediaQuery.sizeOf(context).width * .7,
                child: MapPage(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .31,
        ),
        CustomButton(
            title: 'select rout'.tr(context),
            function: () {
              GoRouter.of(context).push(Routes.kSelectRouts);
            })
      ],
    );
  }
}
