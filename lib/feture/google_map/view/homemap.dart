import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:ptma/feture/google_map/manegar/cubit/map_cubit_cubit.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit()..mapServiceApp(),
      child: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
                target: LatLng(32.409161, 35.279642), zoom: 15),
            onMapCreated: (controller) {
              MapCubit.get(context).googleMapController = controller;
            },
            onTap: (destnation) async {
              MapCubit.get(context).polylines.clear();
              MapCubit.get(context).polylineCoordinates.clear();

              MapCubit.get(context).userDestnationData =
                  LatLng(destnation.latitude, destnation.longitude);
              MapCubit.get(context)
                  .displayPoint(await MapCubit.get(context).getRouteData());
            },
            markers: MapCubit.get(context).markers,
            polylines: MapCubit.get(context).polylines,
          );
        },
      ),
    );
  }
}
