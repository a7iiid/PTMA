import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

import '../../../manger/method.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? gmc;
  // StreamSubscription<Position>? positionStream;
  // StreamSubscription<ServiceStatus>? serviceStatusStream;
  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  late Location location;
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
        polylineId: id,
        color: Colors.green,
        points: polylineCoordinates,
        startCap: Cap.roundCap,
        width: 5);
    polylines[id] = polyline;
    setState(() {});
  }

  Future checkServiceEnabled() async {
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        //TODO: SHOW ERROR BAR
      }
    }
  }

  Future<bool> checkParmission() async {
    var permissionStutas = await location.hasPermission();

    if (permissionStutas == PermissionStatus.denied) {
      permissionStutas = await location.requestPermission();
      if (permissionStutas != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  void getUserLocation() {
    location.changeSettings(distanceFilter: 3);
    var positionStream = Location.instance.onLocationChanged.listen((position) {
      gmc?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(position.latitude!, position.longitude!),
              zoom: 15),
        ),
      );
      markers.add(Marker(
          markerId: MarkerId('user location'),
          position: LatLng(position.latitude!, position.longitude!)));
      setState(() {});
    });
  }

  void mapServiceApp() async {
    await checkServiceEnabled();
    if (await checkParmission()) {
      getUserLocation();
    }
  }

  @override
  void initState() {
    location = Location();
    makeLines();

    super.initState();
    getUserLocation();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    gmc?.dispose();
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
          CameraPosition(target: LatLng(32.409161, 35.279642), zoom: 15),
      onMapCreated: (controller) {
        gmc = controller;
      },
      markers: markers,
      polylines: Set<Polyline>.of(polylines.values),
    );
  }
}
