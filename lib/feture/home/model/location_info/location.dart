import 'dart:convert';

import 'lat_lng.dart';

class Location {
  LatLng? latLng;

  Location({this.latLng});

  factory Location.fromMap(Map<String, dynamic> data) => Location(
        latLng: data['latLng'] == null
            ? null
            : LatLng.fromMap(data['latLng'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'latLng': latLng?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Location].
  factory Location.fromJson(String data) {
    return Location.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Location] to a JSON string.
  String toJson() => json.encode(toMap());
}
