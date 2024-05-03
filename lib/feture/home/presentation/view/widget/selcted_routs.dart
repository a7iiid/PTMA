import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit_cubit.dart';
import 'package:ptma/feture/home/presentation/view/widget/dropdowne.dart';

import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/rout.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../google_map/data/model/station_model.dart';
import '../../../../google_map/view/homemap.dart';
import 'head_home_page.dart';

class SelectRouts extends StatelessWidget {
  SelectRouts({super.key});
  final TextEditingController iconController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const HeadHomePage(),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 20),
                    child: SvgPicture.asset(Assets.imagesMenuIcon),
                  ),
                  Positioned(
                    bottom: -MediaQuery.sizeOf(context).height * .22,
                    left: 40,
                    right: 40,
                    child: Container(
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          color: Colors.amber),
                      height: MediaQuery.sizeOf(context).height * .45,
                      width: MediaQuery.sizeOf(context).width * .7,
                      child: MapPage(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .30,
              ),
              // StationDropdown(
              //   stations: MapCubit().markers.toList(),
              //   onChanged: (Marker station) {
              //     // Do something with the selected station
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
