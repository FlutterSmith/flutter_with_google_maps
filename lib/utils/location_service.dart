import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<bool> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return false;
      }
    }

    return true;
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var isPermissionGranted = await location.hasPermission();

    if (isPermissionGranted == PermissionStatus.deniedForever) {
      return false;
    }

    if (isPermissionGranted == PermissionStatus.denied) {
      isPermissionGranted = await location.requestPermission();

      if (isPermissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) {
    location.onLocationChanged.listen((onData));
  }
}
