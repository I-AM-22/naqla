import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';

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

    markers.add(Marker(
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: const InfoWindow(
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker(
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: const InfoWindow(
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>(),
      child: AppScaffold(
          appBar: AppAppBar(
              back: false,
              appBarParams: AppBarParams(title: S.of(context).home)),
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
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
