import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:ptma/feture/google_map/manegar/map_service.dart';
import 'package:ptma/feture/google_map/manegar/routes_service.dart';

import '../../../core/utils/manger/method.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? googleMapController;

  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  late MapService mapService;
  late RoutesService routesService;
  late LatLng userLocationData;
  late LatLng userDestnationData;
  Set<Polyline> polylinepoint = {};

  Future<void> makeLines() async {
    await polylinePoints
        .getRouteBetweenCoordinates(
      'AIzaSyBA9z9yyAAM6us9MlZtuPkcFgXMOBzozSo',
      PointLatLng(userLocationData.latitude,
          userLocationData.longitude), //Starting LATLANG
      PointLatLng(userDestnationData.latitude,
          userDestnationData.longitude), //End LATLANG

      travelMode: TravelMode.driving,
    )
        .then((value) {
      value.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        routesService.destans(userDestnationData, userLocationData);
      });
    }).then((value) {
      addPolyLine();
    });
  }

  addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.green,
        points: polylineCoordinates,
        startCap: Cap.roundCap,
        width: 4);
    polylines.add(polyline);
    setState(() {});
  }

  void mapServiceApp() async {
    try {
      mapService.getUserRealTimeLocation((position) {
        userLocationData = LatLng(position.latitude!, position.longitude!);
        googleMapController?.animateCamera(
          CameraUpdate.newLatLng(
            userLocationData,
          ),
        );
        setUserMarker(position);
      });
    } on ServiceEnabelExption catch (e) {
      // TODO
    } on PermissionExption catch (e) {
      // TODO
    } on Exception catch (e) {
      //TODO :
    }
  }

  void setUserMarker(LocationData position) async {
    markers.add(
      Marker(
        markerId: MarkerId('user location'),
        position: LatLng(position.latitude!, position.longitude!),
      ),
    );
    if (polylineCoordinates.isNotEmpty) {
      routesService.destans(userDestnationData, userLocationData);
    }

    setState(() {});
  }

  @override
  void initState() {
    mapService = MapService();
    routesService = RoutesService();

    super.initState();
    mapServiceApp();
  }

  @override
  void dispose() {
    googleMapController?.dispose();
    mapService.endMap();

    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    markers.addAll(await initMarkers());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition:
          const CameraPosition(target: LatLng(32.409161, 35.279642), zoom: 15),
      onMapCreated: (controller) {
        googleMapController = controller;
      },
      onTap: (destnation) async {
        polylines.clear();
        polylineCoordinates.clear();

        userDestnationData = LatLng(destnation.latitude, destnation.longitude);
        await makeLines();
      },
      markers: markers,
      polylines: polylines,
    );
  }

  // Future<List<LatLng>> getRouteData() async {
  //   LocationInfoModel origindata = LocationInfoModel(
  //     location: LocationModel(
  //       latLng: LatLngModel(
  //           latitude: userLocationData.latitude,
  //           longitude: userLocationData.longitude),
  //     ),
  //   );
  //   LocationInfoModel destinationData = LocationInfoModel(
  //     location: LocationModel(
  //       latLng: LatLngModel(
  //           latitude: userDestnationData.latitude,
  //           longitude: userDestnationData.longitude),
  //     ),
  //   );
  //   RoutesModel route = await routesService.fetchRoutes(
  //       origindata: origindata, destinationData: destinationData);
  //   List<PointLatLng> result = polylinePoints
  //       .decodePolyline(route.routes!.first.polyline!.encodedPolyline!);
  //   List<LatLng> pointes =
  //       result.map((e) => LatLng(e.latitude, e.longitude)).toList();
  //   return pointes;
  // }

  // void displayPoint(List<LatLng> point) {
  //   Polyline route = Polyline(polylineId: PolylineId('route'), points: point);
  //   polylinepoint.add(route);
  //   setState(() {});
  // }
}
