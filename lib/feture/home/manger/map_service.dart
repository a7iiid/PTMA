import 'package:location/location.dart';

class MapService {
  Location location = Location();
  Future<bool> checkServiceEnabled() async {
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkParmission() async {
    var permissionStutas = await location.hasPermission();

    if (permissionStutas == PermissionStatus.denied) {
      permissionStutas = await location.requestPermission();
      if (permissionStutas != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  void getUserLocation(void Function(LocationData)? onData) {
    location.changeSettings(distanceFilter: 3);
    var positionStream = Location.instance.onLocationChanged.listen(onData);
  }
}
