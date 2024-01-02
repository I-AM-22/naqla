import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user/core/util/extensions/build_context.dart';

class MapHelper {
  static late String darkMapStyle;
  static late String lightMapStyle;

  static Future setCameraPosition({
    required GoogleMapController controller,
    required LatLng start,
    required LatLng destination,
  }) async {
    double miny = (start.latitude <= destination.latitude)
        ? start.latitude
        : destination.latitude;
    double minx = (start.longitude <= destination.longitude)
        ? start.longitude
        : destination.longitude;
    double maxy = (start.latitude <= destination.latitude)
        ? destination.latitude
        : start.latitude;
    double maxX = (start.longitude <= destination.longitude)
        ? destination.longitude
        : start.longitude;

    double southWestLatitude = miny;
    double southWestLongitude = minx;

    double northEastLatitude = maxy;
    double northEastLongitude = maxX;

    final latLngBounds = CameraUpdate.newLatLngBounds(
      LatLngBounds(
        northeast: LatLng(northEastLatitude, northEastLongitude),
        southwest: LatLng(southWestLatitude, southWestLongitude),
      ),
      110.0,
    );

    await controller
        .animateCamera(latLngBounds)
        .then((value) async => await _check(latLngBounds, controller));
  }

  static Future<void> _check(
      CameraUpdate cameraUpdate, GoogleMapController controller) async {
    await controller.animateCamera(cameraUpdate);
    await controller.animateCamera(cameraUpdate);
    LatLngBounds l1 = await controller.getVisibleRegion();
    LatLngBounds l2 = await controller.getVisibleRegion();
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      await _check(cameraUpdate, controller);
    }
  }

  static LatLng midPoint({
    required LatLng start,
    required LatLng destination,
  }) {
    return LatLng(
      (start.latitude + destination.latitude) / 2,
      (start.longitude + destination.longitude) / 2,
    );
  }

  // static Future<BitmapDescriptor> getPinIcon({required PinMapType pinType}) async {
  //   final bytes = await _getBytesFromAsset(pinType.path, 100.r.round());
  //   return BitmapDescriptor.fromBytes(bytes);
  // }

  static Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // static Future loadMapStyles() async {
  //   darkMapStyle = await rootBundle.loadString('assets/map_night_style.json');
  //   lightMapStyle = await rootBundle.loadString('assets/map_light_style.json');
  // }

  static String getMapStyle(BuildContext context) {
    return context.colorScheme.brightness == Brightness.dark
        ? darkMapStyle
        : lightMapStyle;
  }
}
