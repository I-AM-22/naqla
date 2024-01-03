import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:user/core/util/extensions/build_context.dart';

class MapHelper {
  static late String darkMapStyle;
  static late String lightMapStyle;

  static Future setCameraPosition({
    // required GoogleMapController controller,
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

  static Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static String getMapStyle(BuildContext context) {
    return context.colorScheme.brightness == Brightness.dark
        ? darkMapStyle
        : lightMapStyle;
  }
}
