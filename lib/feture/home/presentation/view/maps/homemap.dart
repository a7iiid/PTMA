import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? gmc;
  StreamSubscription<Position>? positionStream;
  StreamSubscription<ServiceStatus>? serviceStatusStream;
  List<Marker> marker = [
    const Marker(
        markerId: MarkerId("1"), position: LatLng(32.411080, 35.282381)),
    const Marker(
      markerId: MarkerId("2"),
      position: LatLng(32.461049, 35.298274),
    )
  ];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  void makeLines() async {
    await polylinePoints
        .getRouteBetweenCoordinates(
      'AIzaSyBA9z9yyAAM6us9MlZtuPkcFgXMOBzozSo',
      PointLatLng(32.411080, 35.282381), //Starting LATLANG
      PointLatLng(32.461049, 35.298274), //End LATLANG
      travelMode: TravelMode.driving,
    )
        .then((value) {
      value.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }).then((value) {
      addPolyLine();
    });
  }

  addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.green, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.whileInUse) {
      positionStream =
          Geolocator.getPositionStream().listen((Position? position) {
        // marker.add(Marker(
        //     markerId: MarkerId('3'),
        //     position: LatLng(position!.latitude, position!.longitude)));

        setState(() {});

        // print(position == null
        //     ? 'Unknown'
        //     : '${position.latitude.toString()}, ${position.longitude.toString()}');
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    makeLines();
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    positionStream!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition:
          CameraPosition(target: LatLng(32.409161, 35.279642), zoom: 15),
      onMapCreated: (controller) {
        gmc = controller;
      },
      markers: marker.toSet(),
      polylines: Set<Polyline>.of(polylines.values),
    );
  }
}
