import 'dart:async';
import 'dart:collection';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';

import '../../../../generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String get path => '/HomePage';
  static String get name => '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng startLocation = const LatLng(36.203977, 37.132782);
  LatLng endLocation = const LatLng(36.187250, 37.134324);
  GoogleMapController? mapController;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  List<LatLng> points = const [
    LatLng(36.203977, 37.132782),
    LatLng(36.203629, 37.132936),
    LatLng(36.203175, 37.132283),
    LatLng(36.20114, 37.133535),
    LatLng(36.200901, 37.133681),
    LatLng(36.2003, 37.133994),
    LatLng(36.200097, 37.134118),
    LatLng(36.19935, 37.134552),
    LatLng(36.199049, 37.134745),
    LatLng(36.197944, 37.136136),
    LatLng(36.197762, 37.136315),
    LatLng(36.196129, 37.136139),
    LatLng(36.195773, 37.136134),
    LatLng(36.195589, 37.136123),
    LatLng(36.194834, 37.136173),
    LatLng(36.194592, 37.136224),
    LatLng(36.194398, 37.136298),
    LatLng(36.193616, 37.136583),
    LatLng(36.193069, 37.136763),
    LatLng(36.192224, 37.137069),
    LatLng(36.191624, 37.137138),
    LatLng(36.191159, 37.136784),
    LatLng(36.190851, 37.136615),
    LatLng(36.190407, 37.136477),
    LatLng(36.189162, 37.136112),
    LatLng(36.188393, 37.135026),
    LatLng(36.187250, 37.134324),
  ];
  final Set<Polygon> _polygon = HashSet<Polygon>();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        body: RSizedBox(
          width: context.fullWidth - 16,
          child: Column(
            children: [
              AppText.titleMedium(S.of(context).congratulations),
              7.verticalSpace,
              AppText.bodySmMedium(
                S.of(context).your_account_is_ready_to_use,
              ),
            ],
          ),
        ),
        btnOkColor: context.colorScheme.primary,
        btnOkOnPress: () {},
      ).show();
    });
    _polygon.add(Polygon(
      polygonId: const PolygonId('1'),

      points: points,

      fillColor: const Color(0xFF404040).withOpacity(0.3),

      strokeColor: const Color(0xFF404040),
      // geodesic: true,

      strokeWidth: 4,
    ));

    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker(
      //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(
            back: false, appBarParams: AppBarParams(title: S.of(context).home)),
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                zoomGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: startLocation,
                  zoom: 16.0,
                ),
                myLocationEnabled: true,
                markers: markers,
                myLocationButtonEnabled: true,
                compassEnabled: true,
                polygons: _polygon,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ));
  }
}
