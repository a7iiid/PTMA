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
import 'head_home_page.dart';

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class SelectRouts extends StatelessWidget {
  SelectRouts({super.key});
  final TextEditingController iconController = TextEditingController();
  IconLabel? selectedIcon;
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
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .30,
              ),
              StationDropdown(
                stations: MapCubit().markers.toList(),
                onChanged: (Marker station) {
                  // Do something with the selected station
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
