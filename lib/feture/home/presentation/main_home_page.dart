import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/core/widget/custom_button.dart';
import 'package:ptma/feture/google_map/view/homemap.dart';
import 'package:ptma/feture/home/presentation/widget/head_home_page.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({
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
          height: MediaQuery.sizeOf(context).height * .30,
        ),
        CustomButton(title: 'select rout', function: () {})
      ],
    );
  }
}