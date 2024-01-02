import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' hide MapType;
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:user/core/common/helper/map_helper.dart';
import 'package:user/core/util/extensions/build_context.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../../core/api/api_utils.dart';
import '../../../../core/util/responsive_padding.dart';
import '../../../../services/location_map_service.dart';
import '../../../home/presentation/bloc/home_bloc.dart';

class MyMap extends StatefulWidget {
  const MyMap(
      {super.key,
      required this.height,
      this.polyLines,
      this.destination,
      this.origin,
      this.controller});
  final double height;
  final Iterable<Polyline>? polyLines;
  final Marker? destination;
  final Marker? origin;
  final Completer<GoogleMapController>? controller;

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late final Completer<GoogleMapController> _controller;
  late final ValueNotifier<Marker?> currentLocation;
  late final CameraPosition _cameraPosition;

  @override
  void initState() {
    currentLocation = ValueNotifier(null);
    setMapList();
    Logger().d(widget.controller);
    _controller = widget.controller ?? Completer();
    super.initState();
  }

  void setMapList(/*HomeBloc homeBloc*/) async {
    LocationData? location = await LocationService().getLocation();
    if (location == null) {
      return;
    }
    currentLocation.value = Marker(
      position: LatLng(location.latitude!, location.longitude!),
      infoWindow: const InfoWindow(title: 'your Location'),
      markerId:
          MarkerId(LatLng(location.latitude!, location.longitude!).toString()),
    ).copyWith(iconParam: BitmapDescriptor.defaultMarkerWithHue(160));
    _cameraPosition = CameraPosition(
      target: LatLng(location.latitude!, location.longitude!),
      zoom: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentLocation,
      builder: (context, newLocation, _) {
        if (currentLocation.value != null) {
          context.read<HomeBloc>().add(
                SetCurrentLocation(
                  location: PointLatLng(
                    currentLocation.value!.position.latitude,
                    currentLocation.value!.position.longitude,
                  ),
                ),
              );
        }
        return currentLocation.value != null
            ? Stack(
                children: [
                  SizedBox(
                    height: widget.height.h,
                    child: GoogleMap(
                      polylines: widget.polyLines == null
                          ? {}
                          : Set.of(widget.polyLines!),
                      initialCameraPosition: CameraPosition(
                        target: widget.origin == null
                            ? LatLng(newLocation!.position.latitude,
                                newLocation.position.longitude)
                            : LatLng(widget.origin!.position.latitude,
                                widget.origin!.position.longitude),
                        zoom: 17,
                      ),
                      onMapCreated: _onMapCreated,
                      zoomControlsEnabled: false,
                      markers: getMarkersSet(
                        currentLocation: newLocation,
                        origin: widget.origin,
                        destination: widget.destination,
                      ),
                    ),
                  ),
                  Padding(
                    padding: HWEdgeInsets.fromLTRB(0, 15.h, 15.h, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        height: 45.w,
                        width: 45.w,
                        child: FloatingActionButton(
                          onPressed: () async {
                            final GoogleMapController controller =
                                await _controller.future;
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                    _cameraPosition));
                            currentLocation.value = Marker(
                              position: LatLng(_cameraPosition.target.latitude,
                                  _cameraPosition.target.longitude),
                              markerId: MarkerId(
                                LatLng(_cameraPosition.target.latitude,
                                        _cameraPosition.target.longitude)
                                    .toString(),
                              ),
                            );
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(90)),
                          ),
                          child: Icon(Icons.location_on_outlined,
                              color: context.colorScheme.onBackground),
                        ),
                      ),
                    ),
                  ),
                  if (widget.destination != null && widget.origin != null)
                    Align(
                      alignment: Alignment.topLeft,
                      child: RPadding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: 45.w,
                          width: 45.w,
                          child: FloatingActionButton(
                            heroTag: "open map ",
                            onPressed: () async {
                              final destination = Coords(
                                  widget.destination!.position.latitude,
                                  widget.destination!.position.longitude);
                              final origin = Coords(
                                  widget.origin!.position.latitude,
                                  widget.origin!.position.longitude);

                              final osMap = Platform.isAndroid
                                  ? MapType.google
                                  : MapType.apple;

                              final availableMaps =
                                  await MapLauncher.installedMaps;
                              if (availableMaps.isEmpty) {
                                showMessage("No available maps!");
                                return;
                              }
                              final bool isExsitGoogleMaps = availableMaps.any(
                                  (element) =>
                                      element.mapType == MapType.google);

                              if (isExsitGoogleMaps) {
                                await MapLauncher.showDirections(
                                  mapType: MapType.google,
                                  destination: destination,
                                  origin: origin,
                                );
                              } else if (availableMaps
                                  .any((element) => element.mapType == osMap)) {
                                await availableMaps
                                    .firstWhere(
                                        (element) => element.mapType == osMap)
                                    .showDirections(
                                        destination: destination,
                                        origin: origin);
                              } else {
                                await availableMaps.first.showDirections(
                                    destination: destination, origin: origin);
                              }
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90)),
                            ),
                            child: Icon(
                              Icons.map,
                              color: context.colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(MapHelper.getMapStyle(context));
    if (widget.origin != null && widget.destination != null) {
      controller.showMarkerInfoWindow(const MarkerId("origin"));
      controller.showMarkerInfoWindow(const MarkerId('destination'));
      await Future.delayed(
          const Duration(milliseconds: 1),
          await MapHelper.setCameraPosition(
            controller: controller,
            start: widget.origin!.position,
            destination: widget.destination!.position,
          ));
    }
    _controller.complete(controller);
  }

  Set<Marker> getMarkersSet({
    required Marker? currentLocation,
    required Marker? origin,
    required Marker? destination,
  }) {
    //* Only current location given
    if (destination == null && origin == null && currentLocation != null) {
      return {currentLocation};
    }
    //* destination and current locatioin given and origing not.
    else if (origin == null && destination != null && currentLocation != null) {
      return {currentLocation, destination};
    }
    //* origin and destination given
    else if (origin != null && destination != null) {
      Marker locationMarker = currentLocation!
        ..copyWith(iconParam: BitmapDescriptor.defaultMarkerWithHue(40));
      return {origin, destination, locationMarker};
    }
    return {};
  }
}
