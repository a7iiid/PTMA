import 'package:flutter/material.dart';
import 'package:ptma/feture/user_profile/presntation/view/widget/edit_profile_page.dart';
import 'package:ptma/feture/user_profile/presntation/view/widget/profile_body.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ProfileBody());
  }
}
