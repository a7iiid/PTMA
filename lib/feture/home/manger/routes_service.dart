import 'dart:convert';

import 'package:ptma/feture/home/model/location_info/location_info.dart';
import 'package:ptma/feture/home/model/route_configers.dart';

import '../model/route_model/route_model.dart';
import 'package:http/http.dart' as http;

class RoutesService {
  String baseUrl = 'https://routes.googleapis.com/directions/v2:computeRoutes';
  String apiKey = 'AIzaSyBA9z9yyAAM6us9MlZtuPkcFgXMOBzozSo';
  Future<RoutesModel> fechRoutes(
      {required LocationInfo origindata,
      required LocationInfo destinationData,
      RouteConfigers? routeConfigers}) async {
    Uri uri = Uri.parse(baseUrl);
    Map<String, String> headers = {
      'Content-Type': ' application/json',
      ' X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask':
          ' routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
    };

    Map<String, dynamic> body = {
      "origin": origindata.toJson(),
      "destination": destinationData.toJson(),
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "routeModifiers": routeConfigers != null
          ? routeConfigers.toJson()
          : RouteConfigers().toJson(),
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };

    var respons = await http.post(uri, headers: headers, body: body);
    if (respons.statusCode == 200) {
      return RoutesModel.fromJson(jsonDecode(respons.body));
    } else {
      throw 'Route Not Found';
    }
  }
}
