import 'dart:convert';

import 'location.dart';

class LocationInfoModel {
  LocationModel? location;

  LocationInfoModel({this.location});

  factory LocationInfoModel.fromMap(Map<String, dynamic> data) =>
      LocationInfoModel(
        location: data['location'] == null
            ? null
            : LocationModel.fromMap(data['location'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'location': location?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LocationInfoModel].
  factory LocationInfoModel.fromJson(String data) {
    return LocationInfoModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LocationInfoModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
