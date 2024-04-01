import 'dart:convert';

import 'polyline.dart';

class RouteModel {
  int? distanceMeters;
  String? duration;
  PolylineModel? polyline;

  RouteModel({this.distanceMeters, this.duration, this.polyline});

  factory RouteModel.fromMap(Map<String, dynamic> data) => RouteModel(
        distanceMeters: data['distanceMeters'] as int?,
        duration: data['duration'] as String?,
        polyline: data['polyline'] == null
            ? null
            : PolylineModel.fromMap(data['polyline'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'distanceMeters': distanceMeters,
        'duration': duration,
        'polyline': polyline?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RouteModel].
  factory RouteModel.fromJson(String data) {
    return RouteModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RouteModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
