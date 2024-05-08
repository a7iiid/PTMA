import 'distance.dart';
import 'duration.dart';

class Element {
  Distance? distance;
  Duration? duration;
  String? status;

  Element({this.distance, this.duration, this.status});

  factory Element.fromJson(Map<String, dynamic> json) => Element(
        distance: json['distance'] == null
            ? null
            : Distance.fromJson(json['distance'] as Map<String, dynamic>),
        duration: json['duration'] == null
            ? null
            : Duration.fromJson(json['duration'] as Map<String, dynamic>),
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'distance': distance?.toJson(),
        'duration': duration?.toJson(),
        'status': status,
      };
}
