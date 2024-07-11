
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../manegar/cubit/map_cubit.dart';

class MapPage extends StatefulWidget {
  MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void didChangeDependencies() async {
    // log('${MapCubit.get(context).markers}=============================');

    if (MapCubit.get(context).selectedBus != null) {
      MapCubit.get(context).displayBusPoint(
        await MapCubit.get(context).getRouteBusData(),
      );
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = MapCubit.get(context);
    return BlocBuilder<MapCubit, MapState>(builder: (context, state) {
      return PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            MapCubit.get(context).clear();
          },
          child: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target:
                  cubit.userLocationData ?? const LatLng(32.409161, 31.279642),
              zoom: 15,
            ),
            onMapCreated: (controller) {
              cubit.googleMapController = controller;
            },
            onTap: (destnation) async {
              try {
                cubit.userDestnationData =
                    LatLng(destnation.latitude, destnation.longitude);
                cubit.displayUserPoint(await cubit.getRouteUserData());
              } catch (e) {}
            },
            markers: cubit.markers,
            polylines: cubit.polylines,
          ));
    });
  }
}
