import 'dart:convert';

class RouteConfigers {
  bool? avoidTolls;
  bool? avoidHighways;
  bool? avoidFerries;

  RouteConfigers({this.avoidTolls, this.avoidHighways, this.avoidFerries});

  factory RouteConfigers.fromMap(Map<String, dynamic> data) {
    return RouteConfigers(
      avoidTolls: data['avoidTolls'] as bool?,
      avoidHighways: data['avoidHighways'] as bool?,
      avoidFerries: data['avoidFerries'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'avoidTolls': avoidTolls,
        'avoidHighways': avoidHighways,
        'avoidFerries': avoidFerries,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RouteConfigers].
  factory RouteConfigers.fromJson(String data) {
    return RouteConfigers.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RouteConfigers] to a JSON string.
  String toJson() => json.encode(toMap());
}
