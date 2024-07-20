import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ptma/core/utils/images.dart';

class DrawerBottom extends StatelessWidget {
  const DrawerBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
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
      ],
    );
  }
}
