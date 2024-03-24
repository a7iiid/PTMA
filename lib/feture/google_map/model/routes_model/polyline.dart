import 'dart:convert';

class PolylineModel {
  String? encodedPolyline;

  PolylineModel({this.encodedPolyline});

  factory PolylineModel.fromMap(Map<String, dynamic> data) => PolylineModel(
        encodedPolyline: data['encodedPolyline'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'encodedPolyline': encodedPolyline,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PolylineModel].
  factory PolylineModel.fromJson(String data) {
    return PolylineModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PolylineModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
