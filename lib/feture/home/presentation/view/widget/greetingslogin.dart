import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';

class Greetingslogin extends StatelessWidget {
  const Greetingslogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Text(
            DateTime.now().hour < 12
                ? " ${"Good morning".tr(context)} ${FirebaseAuth.instance.currentUser!.displayName ?? ''}"
                : "${"Good evening".tr(context)} ${FirebaseAuth.instance.currentUser!.displayName ?? ''}",
            style: AppStyle.normal24,
          ),
          if (DateTime.now().hour < 12)
            const Icon(
              Icons.sunny,
              color: Colors.yellow,
            )
          else
            const Icon(
              Icons.nightlight_round_outlined,
              color: Colors.white,
              size: 25,
            ),
        ],
      ),
    );
  }
}
