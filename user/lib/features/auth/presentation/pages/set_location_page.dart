import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:user/core/config/router/router.dart';
import 'package:user/core/core.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/generated/flutter_gen/assets.gen.dart';

import '../../../../services/location_map_service.dart';

class SetLocationPage extends StatefulWidget {
  const SetLocationPage({super.key});

  @override
  State<SetLocationPage> createState() => _SetLocationPageState();
}

class _SetLocationPageState extends State<SetLocationPage> {
  late Future<LocationData?>? locationData;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: context.fullHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: .5,
                image: AssetImage(Assets.images.jpg.mapBackground.path),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: Container(
              height: 459.h,
              padding: REdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  AppImage.asset(
                    Assets.images.svgs.placeIndicate.path,
                    width: 110.r,
                    height: 110.r,
                  ),
                  const Spacer(),
                  AppText.titleMedium(
                    'Enable your location',
                  ),
                  12.verticalSpace,
                  AppText.subHeadMedium(
                    'Choose your location to start find the request around you',
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  AppButton.dark(
                    stretch: true,
                    onPressed: () {
                      LocationService().getLocation();
                    },
                    title: 'Use my location',
                  ),
                  10.verticalSpace,
                  Center(
                    child: AppButton.ghost(
                      title: 'Skip for now',
                      onPressed: () {
                        context.goNamed(GRouter.config.authRoutes.welcome);
                      },
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
/*SizedBox(
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
          ))*/
