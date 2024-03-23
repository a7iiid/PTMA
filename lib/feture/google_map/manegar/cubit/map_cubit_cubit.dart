import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/manger/method.dart';
import '../map_service.dart';
import '../routes_service.dart';

part 'map_cubit_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  static get(context) => BlocProvider.of<MapCubit>(context);
  GoogleMapController? googleMapController;

  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};
  MapService mapService = MapService();
  late LatLng userLocationData;
  late LatLng userDestnationData;
  RoutesService routesService = RoutesService();
  Set<Marker> markers = {};

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
      setStation();
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
      routesService.destans(userDestnationData, userLocationData);
    }
  }

  void setStation() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('station').get();
    var customMarkerIcone = BitmapDescriptor.fromBytes(
        await getImageFromRowData('assets/images/marker.jpg', 50));
    var myMarker = querySnapshot.docs
        .map((plasemodel) => Marker(
            icon: customMarkerIcone,
            markerId: MarkerId(plasemodel.id),
            position: LatLng(plasemodel['latitude'] as double,
                plasemodel['longitude'] as double),
            infoWindow: InfoWindow(title: plasemodel['name'])))
        .toSet();
    markers.addAll(myMarker);
  }

  Future<void> makeLines({LatLng? start, LatLng? end}) async {
    emit(MapSetLine());
    await PolylinePoints()
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
        // routesService.destans(userDestnationData, userLocationData);
      });
    }).then((value) {
      addPolyLine();
    });
    if (start != null && end != null) {
      await PolylinePoints()
          .getRouteBetweenCoordinates(
        'AIzaSyBA9z9yyAAM6us9MlZtuPkcFgXMOBzozSo',
        PointLatLng(start.latitude, start.longitude), //Starting LATLANG
        PointLatLng(end.latitude, end.longitude), //End LATLANG

        travelMode: TravelMode.driving,
      )
          .then((value) {
        value.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          // routesService.destans(userDestnationData, userLocationData);
        });
      }).then((value) {
        addPolyLine();
      });
    }
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
    emit(MapSuccess());
  }
}
