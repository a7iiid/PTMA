import 'dart:convert';

import 'route.dart';

class RouteModel {
  List<Route>? routes;

  RouteModel({this.routes});

  factory RouteModel.fromMap(Map<String, dynamic> data) => RouteModel(
        routes: (data['routes'] as List<dynamic>?)
            ?.map((e) => Route.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'routes': routes?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RouteModel].
  factory RouteModel.fromJson(String data) {
    return RouteModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RouteModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
