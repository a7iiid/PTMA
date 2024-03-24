import 'dart:convert';

import 'route.dart';

class RoutesModel {
  List<RouteModel>? routes;

  RoutesModel({this.routes});

  factory RoutesModel.fromMap(Map<String, dynamic> data) => RoutesModel(
        routes: (data['routes'] as List<dynamic>?)
            ?.map((e) => RouteModel.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'routes': routes?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RoutesModel].
  factory RoutesModel.fromJson(String data) {
    return RoutesModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RoutesModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
