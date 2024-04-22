import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        top: 24.0,
        bottom: 64.0,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black26,
        shape: BoxShape.circle,
      ),
      child: Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
    );
  }
}
