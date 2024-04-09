import 'package:common_state/common_state.dart';
import 'package:location/location.dart';
import 'package:naqla/core/api/exceptions.dart';

class LocationService {
  FutureResult<LocationData?> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      await location.requestService();
      serviceEnabled = await location.serviceEnabled();
    }
    if (!serviceEnabled) return Left(AppException(message: "service is not enable", exception: Exception()));

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    if (permissionGranted != PermissionStatus.granted && permissionGranted != PermissionStatus.grantedLimited) {
      return Left(AppException(message: "permission is granted", exception: Exception()));
    }
    locationData = await location.getLocation();
    return Right(locationData);
  }
}
