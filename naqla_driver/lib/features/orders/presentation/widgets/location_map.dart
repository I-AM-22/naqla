import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naqla_driver/core/util/core_helper_functions.dart';
import 'package:naqla_driver/features/home/data/model/location_model.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({super.key, required this.locationStart, required this.locationEnd, this.width, this.height});
  final LocationModel locationStart;
  final LocationModel locationEnd;
  final double? width;
  final double? height;

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  Set<Marker> markers = {};
  final Completer<GoogleMapController> _googleMapController = Completer();
  final Set<Polygon> _polygon = HashSet<Polygon>();
  @override
  void initState() {
    super.initState();
    _initMap();
  }

  _initMap() async {
    markers.addAll([
      Marker(
          markerId: const MarkerId('start'),
          position: LatLng(widget.locationStart.latitude, widget.locationStart.longitude),
          icon: BitmapDescriptor.fromBytes(
            await CoreHelperFunctions.getBytesFromAsset('assets/icons/png/map.png', 100),
          ),
          infoWindow: const InfoWindow(title: 'نقطة البداية')),
      Marker(
        markerId: const MarkerId('end'),
        icon: BitmapDescriptor.fromBytes(
          await CoreHelperFunctions.getBytesFromAsset('assets/icons/png/map.png', 100),
        ),
        position: LatLng(widget.locationEnd.latitude, widget.locationEnd.longitude),
        infoWindow: const InfoWindow(title: 'نقطة النهاية'),
      )
    ]);
    setState(() {});
    _polygon.addAll([
      Polygon(
        polygonId: const PolygonId('1'),
        points: [
          LatLng(widget.locationStart.latitude, widget.locationStart.longitude),
          LatLng(widget.locationEnd.latitude, widget.locationEnd.longitude)
        ],
        fillColor: const Color(0xFF404040).withOpacity(0.3),
        strokeColor: const Color(0xFF404040),
        strokeWidth: 4,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 500.h,
      child: GoogleMap(
        key: const Key("MAP"),
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        polygons: _polygon,
        gestureRecognizers: {Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())},
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.locationStart.latitude, widget.locationStart.longitude),
          zoom: 16,
        ),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _googleMapController.complete(controller);
        },
      ),
    );
  }
}
