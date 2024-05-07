import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ptma/feture/home/presentation/manger/cubit/app_cubit.dart';

import '../../../../../core/utils/images.dart';

class ChangePicturs extends StatelessWidget {
  const ChangePicturs({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await AppCubit.get(context).SetUserPictur();
      },
      child: Stack(
        alignment: Alignment.center, // Add this line
        clipBehavior: Clip.none,
        children: [
          Align(
            // Wrap the container with Align
            alignment: Alignment.center, // Add this line
            child: Container(
              width: 133.0,
              height: 133.0,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            // Wrap the container with Align
            alignment: Alignment.center, // Add this line
            child: Container(
                width: 128.0,
                height: 128.0,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: FirebaseAuth.instance.currentUser!.photoURL == null &&
                        AppCubit.get(context).pickImageServes.file == null
                    ? SvgPicture.asset(Assets.imagesUserProfilSvg)
                    : FirebaseAuth.instance.currentUser!.photoURL != null &&
                            AppCubit.get(context).pickImageServes.file != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(
                                AppCubit.get(context).pickImageServes.file!),
                          )
                        : FirebaseAuth.instance.currentUser!.photoURL != null &&
                                AppCubit.get(context).pickImageServes.file ==
                                    null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(FirebaseAuth
                                    .instance.currentUser!.photoURL!),
                              )
                            : SvgPicture.asset(Assets.imagesUserProfilSvg)),
          ),
          Positioned(
            bottom: 5,
            left: MediaQuery.sizeOf(context).width * .36,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 25,
                height: 25.0,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
