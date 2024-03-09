import 'dart:convert';

import 'polyline.dart';

class Route {
  int? distanceMeters;
  String? duration;
  Polyline? polyline;

  Route({this.distanceMeters, this.duration, this.polyline});

  factory Route.fromMap(Map<String, dynamic> data) => Route(
        distanceMeters: data['distanceMeters'] as int?,
        duration: data['duration'] as String?,
        polyline: data['polyline'] == null
            ? null
            : Polyline.fromMap(data['polyline'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'distanceMeters': distanceMeters,
        'duration': duration,
        'polyline': polyline?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Route].
  factory Route.fromJson(String data) {
    return Route.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Route] to a JSON string.
  String toJson() => json.encode(toMap());
}
