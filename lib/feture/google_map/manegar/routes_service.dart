import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/route_configers.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../model/routes_model/routes_model.dart';

class RoutesService {
  // Dio dio = new Dio();

  final String baseUrldirections =
      'https://maps.googleapis.com/maps/api/directions/json';

  final String apiKey = 'AIzaSyBA9z9yyAAM6us9MlZtuPkcFgXMOBzozSo';

  // Future<void> destans(LatLng destination, LatLng start) async {
  //   String baseUrlDistanceMatrix =
  //       'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination.latitude},${destination.longitude}&origins=${start.latitude},${start.longitude}&key=$apiKey';
  //   try {
  //     Response response = await dio.get(baseUrlDistanceMatrix);
  //     print(response);
  //   } on Exception catch (e) {
  //     // TODO
  //   }
  // }

  Future<RoutesModel> fetchRoutes({
    required LatLng origindata,
    required LatLng destinationData,
    RouteConfigers? routeConfigers,
  }) async {
    const String baseUrl =
        'https://routes.googleapis.com/directions/v2:computeRoutes';

    Uri url = Uri.parse(baseUrl);
    Map<String, String> heder = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask':
          'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
    };

    Map<String, dynamic> body = {
      "origin": {
        "location": {
          "latLng": {
            "latitude": origindata.latitude,
            "longitude": origindata.longitude
          }
        }
      },
      "destination": {
        "location": {
          "latLng": {
            "latitude": destinationData.latitude,
            "longitude": destinationData.longitude
          }
        }
      },
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false
      },
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };

    var jsonBody = json.encode(body);

    try {
      var response = await http.post(url, headers: heder, body: jsonBody);

      if (response.statusCode == 200) {
        return RoutesModel.fromJson(response.body);
      } else {
        throw 'Route Not Found ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to fetch routes: $e';
    }
  }
}
