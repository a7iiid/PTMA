import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/core/widget/custom_button.dart';
import 'package:ptma/feture/home/presentation/view/maps/homemap.dart';
import 'package:ptma/shapes/home_screen.dart';

import 'widget/head_home_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(clipBehavior: Clip.none, children: [
              const HeadHomePage(),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: SvgPicture.asset(Assets.imagesMenuIcon),
              ),
              Positioned(
                bottom: -MediaQuery.sizeOf(context).height * .15,
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
            ]),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .244,
            ),
            CustomButton(title: 'select rout', function: () {})
          ],
        ),
      ),
    );
  }
}
