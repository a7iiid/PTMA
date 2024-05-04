import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/model/bus_model.dart';
import '../manegar/cubit/map_cubit.dart';

class MapPage extends StatefulWidget {
  MapPage({super.key, required this.initialCameraPosition, this.busModel});

  final LatLng initialCameraPosition;
  final BusModel? busModel;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void didChangeDependencies() async {
    if (widget.busModel != null) {
      MapCubit.get(context).displayBusPoint(await MapCubit.get(context)
          .getRouteBusData(
              LatLng(widget.busModel!.startlatitude,
                  widget.busModel!.startlongitude),
              LatLng(widget.busModel!.endlatitude,
                  widget.busModel!.endlongitude)));
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return Container(
          height: 300, // adjust the height and width as needed
          width: 400,
          child: GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: widget.initialCameraPosition,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              MapCubit.get(context).googleMapController = controller;
            },
            onTap: (destnation) async {
              try {
                //if (widget.busModel == null) {
                // MapCubit.get(context).polylines.clear();
                await MapCubit.get(context).clearPolyLine();

                MapCubit.get(context).userDestnationData =
                    LatLng(destnation.latitude, destnation.longitude);
                MapCubit.get(context).displayUserPoint(
                    await MapCubit.get(context).getRouteUserData());
              } catch (e) {
                print('Error: $e');
              }
            },
            markers: MapCubit.get(context).markers,
            polylines: MapCubit.get(context).polylines,
            //busModel != null
            //     ? [
            //         Polyline(
            //           polylineId: PolylineId('bus_route'),
            //           color: Colors.blue,
            //           width: 5,
            //           points: [
            //             LatLng(
            //                 busModel!.startlatitude, busModel!.startlongitude),
            //             LatLng(busModel!.endlatitude, busModel!.endlongitude),
            //           ],
            //         ),
            //       ].toSet()
            //     : MapCubit.get(context).polylines,
          ),
        );
      },
    );
  }
}
