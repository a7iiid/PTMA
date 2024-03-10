import 'dart:convert';

import 'distance.dart';
import 'duration.dart';

class Element {
  Distance? distance;
  Duration? duration;
  String? status;

  Element({this.distance, this.duration, this.status});

  factory Element.fromMap(Map<String, dynamic> data) => Element(
        distance: data['distance'] == null
            ? null
            : Distance.fromMap(data['distance'] as Map<String, dynamic>),
        duration: data['duration'] == null
            ? null
            : Duration.fromMap(data['duration'] as Map<String, dynamic>),
        status: data['status'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'distance': distance?.toMap(),
        'duration': duration?.toMap(),
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Element].
  factory Element.fromJson(String data) {
    return Element.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Element] to a JSON string.
  String toJson() => json.encode(toMap());
}
