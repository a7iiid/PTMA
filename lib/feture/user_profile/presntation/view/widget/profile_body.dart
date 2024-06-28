import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../../core/widget/user_image.dart';
import '../../../../home/presentation/view/widget/head_home_page.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const HeadHomePage(),
        Positioned(
            left: MediaQuery.sizeOf(context).width * .347,
            bottom: -MediaQuery.sizeOf(context).height * .12,
            child: Column(
              children: [
                const UserImage(),
              ],
            ))
      ],
    );
  }
}
