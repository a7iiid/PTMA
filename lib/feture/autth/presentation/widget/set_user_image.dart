import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/feture/autth/manger/cubit/auth_cubit.dart';

class SetUserImage extends StatelessWidget {
  SetUserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await AuthAppCubit.get(context).SetUserPictur();
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
              child: AuthAppCubit.get(context).pickImageServes.file == null
                  ? SvgPicture.asset(Assets.imagesUserProfilSvg)
                  : CircleAvatar(
                      backgroundImage: FileImage(
                          AuthAppCubit.get(context).pickImageServes.file!)),
            ),
          ),
          Positioned(
            bottom: 1,
            left: MediaQuery.sizeOf(context).width * .30,
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
