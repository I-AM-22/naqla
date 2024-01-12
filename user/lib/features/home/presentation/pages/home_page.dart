import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:user/core/core.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/generated/locale_keys.g.dart';

import '../../../../services/location_map_service.dart';
import '../../../app/presentation/widgets/loading_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String get path => '/HomePage';
  static String get name => '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<LocationData?>? locationData;
  @override
  void initState() {
    locationData = LocationService().getLocation();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        body: RSizedBox(
          width: context.fullWidth - 16,
          child: Column(
            children: [
              AppText.titleMedium(LocaleKeys.signUp_Congratulations.tr()),
              7.verticalSpace,
              AppText.bodySmMedium(
                LocaleKeys.signUp_Your_account_is_ready_to_use.tr(),
              ),
            ],
          ),
        ),
        btnOkColor: context.colorScheme.primary,
        btnOkOnPress: () {},
      ).show();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: CustomerAppBar(back: true, appBarParams: AppBarParams()),
        body: Column(
          children: [
            SizedBox(
                width: double.infinity,
                height: context.fullHeight / 2,
                child: FutureBuilder(
                  future: locationData,
                  builder: (context, snapShot) {
                    if (snapShot.hasData || snapShot.data != null) {
                      return FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(
                              snapShot.data!.latitude ?? 36.204047,
                              snapShot.data!.longitude ?? 37.132776),
                          initialZoom: 10,
                        ),
                        children: [
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                  points: [
                                    LatLng(36.204652, 37.1331812),
                                    LatLng(36.204627, 37.13333),
                                    LatLng(36.203773, 37.133701),
                                    LatLng(36.203175, 37.132283),
                                    LatLng(36.20114, 37.133535),
                                    LatLng(36.200901, 37.133681),
                                    LatLng(36.2003, 37.133994),
                                    LatLng(36.200097, 37.134118),
                                    LatLng(36.19935, 37.134552),
                                    LatLng(36.199049, 37.134745),
                                    LatLng(36.197944, 37.136136),
                                  ],
                                  color: Colors.yellowAccent,
                                  borderStrokeWidth: 500,
                                  strokeWidth: 100),
                              Polyline(
                                points: [],
                                color: Colors.yellowAccent,
                              ),
                              Polyline(
                                points: [],
                                color: Colors.yellowAccent,
                              ),
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
                ))
          ],
        ));
  }
}
