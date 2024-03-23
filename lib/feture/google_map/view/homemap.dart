import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit_cubit.dart';
import 'package:ptma/feture/google_map/manegar/map_service.dart';
import 'package:ptma/feture/google_map/manegar/routes_service.dart';

import '../../../core/utils/manger/method.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  @override
  // GoogleMapController? googleMapController;

  // Set<Marker> markers = {};
  // PolylinePoints polylinePoints = PolylinePoints();
  // Set<Polyline> polylines = {};
  // List<LatLng> polylineCoordinates = [];
  // late MapService mapService;
  // late RoutesService routesService;
  // late LatLng userLocationData;
  // late LatLng userDestnationData;
  // Set<Polyline> polylinepoint = {};

  // Future<void> makeLines() async {
  //   await PolylinePoints()
  //       .getRouteBetweenCoordinates(
  //     'AIzaSyBA9z9yyAAM6us9MlZtuPkcFgXMOBzozSo',
  //     PointLatLng(userLocationData.latitude,
  //         userLocationData.longitude), //Starting LATLANG
  //     PointLatLng(userDestnationData.latitude,
  //         userDestnationData.longitude), //End LATLANG

  //     travelMode: TravelMode.driving,
  //   )
  //       .then((value) {
  //     value.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //       // routesService.destans(userDestnationData, userLocationData);
  //     });
  //   }).then((value) {
  //     addPolyLine();
  //   });
  // }

  // addPolyLine() {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //       polylineId: id,
  //       color: Colors.green,
  //       points: polylineCoordinates,
  //       startCap: Cap.roundCap,
  //       width: 4);
  //   polylines.add(polyline);
  // }

  // void mapServiceApp() async {
  //   try {
  //     mapService.getUserRealTimeLocation((position) {
  //       userLocationData = LatLng(position.latitude!, position.longitude!);
  //       googleMapController?.animateCamera(
  //         CameraUpdate.newLatLng(
  //           userLocationData,
  //         ),
  //       );
  //       setUserMarker(position);
  //     });
  //   } on ServiceEnabelExption catch (e) {
  //     // TODO
  //   } on PermissionExption catch (e) {
  //     // TODO
  //   } on Exception catch (e) {
  //     //TODO :
  //   }
  // }

  // void setUserMarker(LocationData position) async {
  //   markers.add(
  //     Marker(
  //       markerId: MarkerId('user location'),
  //       position: LatLng(position.latitude!, position.longitude!),
  //     ),
  //   );
  //   if (polylineCoordinates.isNotEmpty) {
  //     routesService.destans(userDestnationData, userLocationData);
  //   }

  //   setState(() {});
  // }

//   @override
//   void initState() {
// //     mapService = MapService();
// //     routesService = RoutesService();
// // mapServiceApp();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     googleMapController?.dispose();
//     // mapService.endMap();

//     super.dispose();
//   }

//   @override
//   void didChangeDependencies() async {
//     MapCubit.get(context).markers.addAll(await initMarkers());
//     super.didChangeDependencies();
//   }

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
              await MapCubit.get(context).makeLines();
            },
            markers: MapCubit.get(context).markers,
            polylines: MapCubit.get(context).polylines,
          );
        },
      ),
    );
  }
}
