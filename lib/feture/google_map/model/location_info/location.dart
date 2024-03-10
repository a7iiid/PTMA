import 'dart:convert';

import 'lat_lng.dart';

class LocationModel {
  LatLngModel? latLng;

  LocationModel({this.latLng});

  factory LocationModel.fromMap(Map<String, dynamic> data) => LocationModel(
        latLng: data['latLng'] == null
            ? null
            : LatLngModel.fromMap(data['latLng'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'latLng': latLng?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LocationModel].
  factory LocationModel.fromJson(String data) {
    return LocationModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LocationModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
