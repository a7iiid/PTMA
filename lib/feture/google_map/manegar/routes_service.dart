import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ptma/feture/google_map/model/location_info/location_info.dart';
import 'package:ptma/feture/google_map/model/route_configers.dart';

import '../model/route_model/route_model.dart';
import 'package:dio/dio.dart';

class RoutesService {
  Dio dio = new Dio();

  final String baseUrldirections =
      'https://maps.googleapis.com/maps/api/directions/json';

  final String apiKey = 'AIzaSyBA9z9yyAAM6us9MlZtuPkcFgXMOBzozSo';

  Future<void> destans(LatLng destination, LatLng start) async {
    String baseUrlDistanceMatrix =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination.latitude},${destination.longitude}&origins=${start.latitude},${start.longitude}&key=$apiKey';
    try {
      Response response = await dio.get(baseUrlDistanceMatrix);
      print(response);
    } on Exception catch (e) {
      // TODO
    }
  }

  // Future<RoutesModel> fechRoutes(
  //     {required LocationInfoModel origindata,
  //     required LocationInfoModel destinationData,
  //     RouteConfigers? routeConfigers}) async {
  //   Uri uri = Uri.parse(baseUrldirections);
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'X-Goog-Api-Key': 'AIzaSyBA9z9yyAAM6us9MlZtuPkcFgXMOBzozSo',
  //     'X-Goog-FieldMask':
  //         'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
  //   };

  //   Map<String, dynamic> body = {
  //     "origin": origindata.toJson(),
  //     "destination": destinationData.toJson(),
  //     "travelMode": "DRIVE",
  //     "routingPreference": "TRAFFIC_AWARE",
  //     "routeModifiers": routeConfigers != null
  //         ? routeConfigers.toJson()
  //         : RouteConfigers().toJson(),
  //     "languageCode": "en-US",
  //     "units": "IMPERIAL"
  //   };

  //   var respons =
  //       await http.post(uri, headers: headers, body: jsonEncode(body));
  //   if (respons.statusCode == 200) {
  //     return RoutesModel.fromJson(jsonDecode(respons.body));
  //   } else {
  //     throw 'Route Not Found${respons.statusCode}';
  //   }
  // }
}
