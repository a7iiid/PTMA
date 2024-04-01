import 'dart:async';

import 'package:location/location.dart';

class MapService {
  Location location = Location();
  static StreamSubscription<LocationData>? positionStream;

  Future<void> checkServiceEnabled() async {
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw ServiceEnabelExption();
      }
    }
    //return true;
  }

  Future<void> checkParmission() async {
    var permissionStutas = await location.hasPermission();

    if (permissionStutas == PermissionStatus.denied) {
      permissionStutas = await location.requestPermission();
      if (permissionStutas != PermissionStatus.granted) {
        throw PermissionExption();
      }
    }

    // return true;
  }

  void getUserRealTimeLocation(void Function(LocationData)? onData) async {
    await checkServiceEnabled();
    await checkParmission();
    location.changeSettings(distanceFilter: 3);
    positionStream = Location.instance.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLucation() async {
    await checkServiceEnabled();
    await checkParmission();
    return await location.getLocation();
  }

  void endMap() {
    positionStream!.cancel();
  }
}

class ServiceEnabelExption implements Exception {}

class PermissionExption implements Exception {}
