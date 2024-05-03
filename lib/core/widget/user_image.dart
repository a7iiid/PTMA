import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/images.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128.0,
      height: 128.0,
      margin: const EdgeInsets.only(
        top: 34.0,
        bottom: 42,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black26,
        shape: BoxShape.circle,
      ),
      child: FirebaseAuth.instance.currentUser!.photoURL == null
          ? SvgPicture.asset(Assets.imagesUserProfilSvg)
          : Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
    );
  }
}
