import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaseModel {
  final String id;
  final String name;
  final LatLng latLng;

  PlaseModel({required this.id, required this.name, required this.latLng});
}
