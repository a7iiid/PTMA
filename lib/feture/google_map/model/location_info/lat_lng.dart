import 'dart:convert';

class LatLngModel {
  double? latitude;
  double? longitude;

  LatLngModel({this.latitude, this.longitude});

  factory LatLngModel.fromMap(Map<String, dynamic> data) => LatLngModel(
        latitude: (data['latitude'] as num?)?.toDouble(),
        longitude: (data['longitude'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LatLngModel].
  factory LatLngModel.fromJson(String data) {
    return LatLngModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LatLngModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
