import 'package:flutter/material.dart';
import 'package:ptma/core/widget/user_image.dart';
import 'package:ptma/feture/user_profile/presntation/view/widget/change_pictaer.dart';

import '../../../../autth/presentation/widget/set_user_image.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [ChangePicturs()],
    );
  }
}
