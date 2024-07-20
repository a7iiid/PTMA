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
  MapRouteBus({super.key});

  @override
  State<MapRouteBus> createState() => _MapRouteBusState();
}

class _MapRouteBusState extends State<MapRouteBus> {
  @override
  void didChangeDependencies() async {
    MapCubit.get(context)
        .displayUserPoint(await MapCubit.get(context).getRouteBusData());

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  StationModel? distnationStation;

  Widget build(BuildContext context) {
    var cubit = MapCubit.get(context);
    return PopScope(
      onPopInvoked: (didPop) {
        cubit.clear();
      },
      child: Scaffold(
          body: Stack(
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: cubit.selectedBus != null
                  ? FirebaseFirestore.instance
                      .collection("bus")
                      .doc(cubit.selectedBus!.id)
                      .snapshots()
                  : null,
              builder: (context, snapshot) {
                if (snapshot.hasData && cubit.selectedBus != null) {
                  cubit.setSelectedBus(BusModel.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>,
                      cubit.selectedBus!.id));

                  cubit.displaySelectedBusLocation();
                }
                return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height,
                  child: MapPage(),
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
                    cubit.userDestnationData = LatLng(
                        value!.stationLocation.latitude,
                        value.stationLocation.longitude);
                    cubit.displayUserPoint(await cubit.getRouteUserData());
                  },
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
