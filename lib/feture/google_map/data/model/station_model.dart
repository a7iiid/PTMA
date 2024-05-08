import 'package:cloud_firestore/cloud_firestore.dart';

class StationModel {
  final String name;
  final GeoPoint stationLocation;

  StationModel({required this.stationLocation, required this.name});
  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      name: json['name'],
      stationLocation: json['stationLocation'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'stationLocation': stationLocation};
  }
}
