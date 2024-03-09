import 'dart:convert';

import 'location.dart';

class LocationInfo {
  Location? location;

  LocationInfo({this.location});

  factory LocationInfo.fromMap(Map<String, dynamic> data) => LocationInfo(
        location: data['location'] == null
            ? null
            : Location.fromMap(data['location'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'location': location?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LocationInfo].
  factory LocationInfo.fromJson(String data) {
    return LocationInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LocationInfo] to a JSON string.
  String toJson() => json.encode(toMap());
}
