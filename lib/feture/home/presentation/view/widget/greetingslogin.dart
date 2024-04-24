import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptma/core/utils/Style.dart';

class Greetingslogin extends StatelessWidget {
  const Greetingslogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120, left: 20),
      child: Row(
        children: [
          Text(
            'Good ${DateTime.now().hour < 12 ? 'morning' : 'evening'}, ${FirebaseAuth.instance.currentUser!.displayName ?? ''}  ',
            style: AppStyle.normal24,
          ),
          if (DateTime.now().hour < 12)
            const Icon(
              Icons.sunny,
              color: Colors.yellow,
            )
          else
            const Icon(
              Icons.nightlight_round,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}
