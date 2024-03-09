import 'dart:convert';

class LatLng {
  double? latitude;
  double? longitude;

  LatLng({this.latitude, this.longitude});

  factory LatLng.fromMap(Map<String, dynamic> data) => LatLng(
        latitude: (data['latitude'] as num?)?.toDouble(),
        longitude: (data['longitude'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LatLng].
  factory LatLng.fromJson(String data) {
    return LatLng.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LatLng] to a JSON string.
  String toJson() => json.encode(toMap());
}
