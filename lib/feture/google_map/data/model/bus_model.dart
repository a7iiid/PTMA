import 'package:cloud_firestore/cloud_firestore.dart';

import 'distance_model/distance_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusModel {
  final GeoPoint busLocation;
  final GeoPoint startStation;

  final GeoPoint endStation;

  final String busname;

  final String busnumber;
  final bool isActive;
  final String id;
  DistanceModel? duration;

  BusModel(
      {required this.busname,
      required this.busnumber,
      required this.isActive,
      required this.busLocation,
      required this.endStation,
      required this.startStation,
      required this.id,
      this.duration});

  factory BusModel.fromJson(Map<String, dynamic> json, String id) {
    return BusModel(
      id: id,
      busname: json['busname'],
      busnumber: json['busnumber'],
      busLocation: json['busLocation'],
      endStation: json['endStation'],
      startStation: json['startStation'],
      isActive: json['isActive'],
    );
  }
}
