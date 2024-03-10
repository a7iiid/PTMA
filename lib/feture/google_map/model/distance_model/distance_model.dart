import 'dart:convert';

import 'element.dart';

class DistanceModel {
  List<Element>? elements;

  DistanceModel({this.elements});

  factory DistanceModel.fromMap(Map<String, dynamic> data) => DistanceModel(
        elements: (data['elements'] as List<dynamic>?)
            ?.map((e) => Element.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'elements': elements?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DistanceModel].
  factory DistanceModel.fromJson(String data) {
    return DistanceModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DistanceModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
