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

  Future<RoutesModel> fetchRoutes({
    required LocationInfoModel origindata,
    required LocationInfoModel destinationData,
    RouteConfigers? routeConfigers,
  }) async {
    final dio = Dio();
    const String baseUrl =
        'https://routes.googleapis.com/directions/v2:computeRoutes';
    const String apiKey = 'AIzaSyBA9z9yyAAM6us9MlZtuPkcFgXMOBzozSo';

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

    try {
      final response = await dio.post(
        baseUrl,
        queryParameters: {'key': apiKey},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-FieldMask':
                'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
          },
        ),
        data: body,
      );

      if (response.statusCode == 200) {
        return RoutesModel.fromJson(response.data);
      } else {
        throw 'Route Not Found ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to fetch routes: $e';
    }
  }
}
