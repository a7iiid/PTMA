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
              child: AppCubit.get(context).pickImageServes.file == null
                  ? SvgPicture.asset(Assets.imagesUserProfilSvg)
                  : CircleAvatar(
                      backgroundImage: FileImage(
                          AppCubit.get(context).pickImageServes.file!)),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 120,
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
