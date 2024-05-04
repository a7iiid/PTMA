import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:ptma/feture/google_map/data/model/bus_model.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit.dart';
import 'package:ptma/feture/google_map/view/homemap.dart';
import 'package:ptma/feture/home/presentation/view/widget/head_home_page.dart';

import 'drawer_bottom.dart';

class MapRouteBus extends StatefulWidget {
  MapRouteBus({super.key, required this.busModel});
  BusModel busModel;

  @override
  State<MapRouteBus> createState() => _MapRouteBusState();
}

class _MapRouteBusState extends State<MapRouteBus> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        MapCubit.get(context).clear();
      },
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const HeadHomePage(),
                const DrawerBottom(),
                Positioned(
                  bottom: -MediaQuery.sizeOf(context).height * .29,
                  left: 40,
                  right: 40,
                  child: Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                    height: MediaQuery.sizeOf(context).height * .45,
                    width: MediaQuery.sizeOf(context).width * .7,
                    child: MapPage(
                      initialCameraPosition: LatLng(widget.busModel.buslatitude,
                          widget.busModel.buslongitude),
                      busModel: widget.busModel,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .31,
            ),
          ],
        ),
      ),
    );
  }
}
