import 'dart:convert';

class Polyline {
  String? encodedPolyline;

  Polyline({this.encodedPolyline});

  factory Polyline.fromMap(Map<String, dynamic> data) => Polyline(
        encodedPolyline: data['encodedPolyline'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'encodedPolyline': encodedPolyline,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Polyline].
  factory Polyline.fromJson(String data) {
    return Polyline.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Polyline] to a JSON string.
  String toJson() => json.encode(toMap());
}
