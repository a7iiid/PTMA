import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:ptma/feture/google_map/data/model/bus_model.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit.dart';
import 'package:ptma/feture/google_map/view/homemap.dart';
import 'package:ptma/feture/home/presentation/view/widget/station_menue.dart';

import '../../../../google_map/data/model/station_model.dart';

class MapRouteBus extends StatefulWidget {
  MapRouteBus({super.key, this.busModel});
  BusModel? busModel;

  @override
  State<MapRouteBus> createState() => _MapRouteBusState();
}

class _MapRouteBusState extends State<MapRouteBus> {
  @override
  void initState() {
    if (widget.busModel != null) {
      MapCubit.get(context).setSelectedBus(widget.busModel!);
    }

    super.initState();
  }

  StationModel? distnationStation;

  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
          await MapCubit.get(context).clear();
        },
        child: Scaffold(
            body: Stack(
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("bus")
                    .doc(widget.busModel!.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    widget.busModel = BusModel.fromJson(
                        snapshot.data!.data() as Map<String, dynamic>,
                        widget.busModel!.id);
                    MapCubit.get(context).setSelectedBus(widget.busModel!);

                    MapCubit.get(context).displaySelectedBusLocation();
                  }
                  log("${widget.busModel!.buslatitude}");
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height,
                    child: MapPage(
                      busModel: widget.busModel,
                    ),
                  );
                }),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: DropMenuItem(
                    location: distnationStation,
                    onChanged: (value) async {
                      distnationStation = value;
                      MapCubit.get(context).userDestnationData =
                          LatLng(value!.latitude, value.longitude);
                      MapCubit.get(context).displayUserPoint(
                          await MapCubit.get(context).getRouteUserData());
                    },
                  ),
                ),
              ],
            )
          ],
        )));
  }
}
