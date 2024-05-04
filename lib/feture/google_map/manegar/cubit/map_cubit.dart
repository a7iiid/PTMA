import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:ptma/core/utils/apiKey.dart';
import 'package:ptma/feture/google_map/data/model/bus_model.dart';

import '../../../../core/utils/manger/method.dart';
import '../../data/model/routes_model/routes_model.dart';
import '../../../../core/utils/ApiServes/map_service.dart';
import '../../../../core/utils/ApiServes/routes_service.dart';
import 'package:dio/dio.dart';

import '../../data/model/station_model.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  static MapCubit get(context) => BlocProvider.of<MapCubit>(context);
  GoogleMapController? googleMapController;

  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};
  MapService mapService = MapService();
  late LatLng userLocationData;
  late LatLng userDestnationData;
  RoutesService routesService = RoutesService();
  Set<Marker> markers = {};
  List<StationModel> stationModel = [];
  List<BusModel> busModel = [];

  PolylinePoints polylinePoints = PolylinePoints();

  Dio dio = Dio();

  void mapServiceApp() async {
    try {
      emit(MapCheckService());
      mapService.getUserRealTimeLocation((position) {
        userLocationData = LatLng(position.latitude!, position.longitude!);
        googleMapController?.animateCamera(
          CameraUpdate.newLatLng(
            userLocationData,
          ),
        );
        setUserMarker(position);
      });
      await getStationFromFireBase();
      setStation();
      await getBusFromFireBase();
      emit(MapSuccess());
    } on ServiceEnabelExption catch (e) {
      // TODO
    } on PermissionExption catch (e) {
      // TODO
    } on Exception catch (e) {
      //TODO :
    }
  }

  void setUserMarker(LocationData position) async {
    emit(MapSetMarker());
    markers.add(
      Marker(
        markerId: const MarkerId('user location'),
        position: LatLng(position.latitude!, position.longitude!),
      ),
    );
    if (polylineCoordinates.isNotEmpty) {
      //routesService.destans(userDestnationData, userLocationData);
    }
  }

  Future<void> getBusFromFireBase() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('bus')
        .where('isActeve', isEqualTo: true)
        .get();

    var buses = querySnapshot.docs;
    var busData = buses
        .map((doc) => BusModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    busModel.addAll(busData);
  }

  Future<void> getStationFromFireBase() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('station').get();

    var station = querySnapshot.docs;
    var stationdata = station
        .map((doc) => StationModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    stationModel.addAll(stationdata);
  }

  void setStation() async {
    // List<StationModel> stationModel = await getStationFromFireBase();
    var customMarkerIcone = BitmapDescriptor.fromBytes(
        await getImageFromRowData('assets/images/marker.jpg', 50));
    var myMarker = stationModel
        .map((station) => Marker(
              icon: customMarkerIcone,
              markerId: MarkerId(station.name),
              position: LatLng(station.latitude, station.longitude),
              infoWindow: InfoWindow(title: station.name),
            ))
        .toSet();
    markers.addAll(myMarker);
  }

  Future<void> destans(LatLng destination, LatLng start) async {
    String baseUrlDistanceMatrix =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination.latitude},${destination.longitude}&origins=${start.latitude},${start.longitude}&key=${ApiKey.mapApiKey}';
    try {
      Response response = await dio.get(baseUrlDistanceMatrix);
      print(response);
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<List<LatLng>> getRouteData() async {
    RoutesModel route = await routesService.fetchRoutes(
        origindata: userLocationData, destinationData: userDestnationData);

    List<PointLatLng> result = polylinePoints
        .decodePolyline(route.routes!.first.polyline!.encodedPolyline!);
    List<LatLng> pointes =
        result.map((e) => LatLng(e.latitude, e.longitude)).toList();
    return pointes;
  }

  void displayPoint(List<LatLng> point) {
    Polyline route = Polyline(
        polylineId: PolylineId('route'),
        points: point,
        color: Colors.green,
        startCap: Cap.roundCap,
        width: 4);
    polylines.add(route);
    emit(MapSetLine());
  }
}
//  Future<void> makeLines({LatLng? start, LatLng? end}) async {
//     emit(MapSetLine());
//     await PolylinePoints()
//         .getRouteBetweenCoordinates(
//       apikey,
//       PointLatLng(userLocationData.latitude,
//           userLocationData.longitude), //Starting LATLANG
//       PointLatLng(userDestnationData.latitude,
//           userDestnationData.longitude), //End LATLANG

//       travelMode: TravelMode.driving,
//     )
//         .then((value) {
//       value.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//         // routesService.destans(userDestnationData, userLocationData);
//       });
//     }).then((value) {
//       addPolyLine();
//     });
//     if (start != null && end != null) {
//       await PolylinePoints()
//           .getRouteBetweenCoordinates(
//         'AIzaSyBA9z9yyAAM6us9MlZtuPkcFgXMOBzozSo',
//         PointLatLng(start.latitude, start.longitude), //Starting LATLANG
//         PointLatLng(end.latitude, end.longitude), //End LATLANG

//         travelMode: TravelMode.driving,
//       )
//           .then((value) {
//         value.points.forEach((PointLatLng point) {
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//           // routesService.destans(userDestnationData, userLocationData);
//         });
//       }).then((value) {
//         addPolyLine();
//       });
//     }
//   }

//   addPolyLine() {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//         polylineId: id,
//         color: Colors.green,
//         points: polylineCoordinates,
//         startCap: Cap.roundCap,
//         width: 4);
//     polylines.add(polyline);
//     emit(MapSuccess());
//   }
