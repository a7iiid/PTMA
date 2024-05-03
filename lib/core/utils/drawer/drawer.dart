import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ptma/core/utils/drawer/shape_of_drawer.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';

import '../../widget/user_image.dart';
import '../rout.dart';

class CustomeDrawer extends StatelessWidget {
  const CustomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * .7,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            // Add a background color or gradient
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                const Color(0xff1937FE).withOpacity(1),
                const Color(0xff4960F9).withOpacity(1)
              ],
            ),
          ),
          child: ListTileTheme(
            textColor: const Color(0xff1937FE).withOpacity(1),
            iconColor: const Color(0xff4960F9).withOpacity(1),
            child: Stack(
              children: [
                Positioned(
                    bottom: 1,
                    child: Transform.rotate(
                        angle: pi, child: const ShapeOfDrawer())),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const UserImage(),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.account_circle_rounded),
                      title: Text('Profile'.tr(context)),
                    ),
                    ListTile(
                      onTap: () {
                        GoRouter.of(context).pushReplacement(Routes.kSettings);
                      },
                      leading: Icon(Icons.settings),
                      title: Text('Settings'.tr(context)),
                    ),
                    ListTile(
                      title: Text("Sign Out".tr(context)),
                      leading: Icon(Icons.output_outlined),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().then((value) =>
                            GoRouter.of(context)
                                .pushReplacement(Routes.kMainScreen));
                      },
                    ),
                    Spacer(),
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Text(
                            'Terms of Service | Privacy Policy'.tr(context)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
