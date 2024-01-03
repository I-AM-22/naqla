import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:user/core/config/extension/poly_line_ext.dart';
import 'package:user/core/util/extensions/build_context.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/app_svg_picture.dart';
import 'package:user/features/app/presentation/widgets/loading_indicator.dart';
import 'package:user/generated/flutter_gen/assets.gen.dart';

import '../../../../services/location_map_service.dart';
export 'package:google_polyline_algorithm/google_polyline_algorithm.dart'
    show decodePolyline;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late Future<LocationData?>? locationData;
  @override
  void initState() {
    locationData = LocationService().getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: context.colorScheme.background,
      body: SizedBox(
          width: double.infinity,
          height: context.fullHeight / 2,
          child: FutureBuilder(
            future: locationData,
            builder: (context, snapShot) {
              if (snapShot.hasData || snapShot.data != null) {
                return FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(snapShot.data!.latitude ?? 36.204047,
                        snapShot.data!.longitude ?? 37.132776),
                    initialZoom: 10,
                  ),
                  children: [
                    PolylineLayer(
                      polylines: [
                        Polyline(
                            points: [
                              LatLng(36.204047, 37.13277636),
                            ],
                            color: Colors.yellowAccent,
                            borderStrokeWidth: 500,
                            strokeWidth: 100),
                        Polyline(
                            points: [LatLng(36.187250, 37.134324)],
                            color: Colors.yellowAccent,
                            borderStrokeWidth: 500,
                            strokeWidth: 100),
                      ],
                    ),
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    CurrentLocationLayer(
                      style: LocationMarkerStyle(
                        marker: DefaultLocationMarker(
                          child: Icon(
                            Icons.navigation,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        // accuracyCircleColor: context.colorScheme.primary,
                        // headingSectorColor: context.colorScheme.primary,
                        markerSize: Size(40, 40),
                        markerDirection: MarkerDirection.north,
                      ),
                    )
                  ],
                );
              }
              return Center(child: LoadingIndicator());
            },
          )),
    );
  }
}
