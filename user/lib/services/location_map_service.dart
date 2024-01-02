import 'package:location/location.dart';

class LocationService {
  Future<LocationData?> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      await location.requestService();
      serviceEnabled = await location.serviceEnabled();
    }
    if (!serviceEnabled) return null;

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    if (permissionGranted != PermissionStatus.granted &&
        permissionGranted != PermissionStatus.grantedLimited) return null;
    locationData = await location.getLocation();
    return locationData;
  }
}
