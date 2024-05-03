import 'dart:async';
import 'dart:collection';

import 'package:common_state/common_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naqla/core/config/themes/app_theme.dart';
import 'package:naqla/core/util/extensions.dart';

import '../../../../core/global_widgets/app_button.dart';
import '../../../../core/global_widgets/app_image.dart';
import '../../../../core/global_widgets/custom_text_field.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../bloc/home_bloc.dart';

class SetLocationOrder extends StatefulWidget {
  const SetLocationOrder(
      {super.key, required this.onValid, required this.onChanged});
  final Function(List? value) onValid;
  final Function(List<LatLng>? value) onChanged;

  @override
  State<SetLocationOrder> createState() => _SetLocationOrderState();
}

class _SetLocationOrderState extends State<SetLocationOrder> {
  double? latitude, longitude;
  CameraPosition? cameraPosition;
  Set<Marker> markers = {};
  final Completer<GoogleMapController> _googleMapController = Completer();
  List<LatLng> listMarkers = [];
  final Set<Polygon> _polygon = HashSet<Polygon>();
  List<LatLng> points = [];
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final startEndPoint = [
          S.of(context).start_point,
          S.of(context).end_point,
        ];
        return CustomFormField<List<LatLng>>(
            validator: (value) {
              widget.onValid(value);
              if (value?.isEmpty ?? false) {
                return "يجب تحديد نقطة البداية والنهاية";
              } else if ((value?.length ?? 0) < 2) {
                return "يجب تحديد نقطة النهاية";
              } else {
                return null;
              }
            },
            child: (p0) => Stack(
                  children: [
                    SizedBox(
                      height: 250.h,
                      child: GoogleMap(
                        key: const Key("MAP"),
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        polygons: _polygon,
                        gestureRecognizers: {
                          Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer())
                        },
                        initialCameraPosition: cameraPosition ??
                            const CameraPosition(
                              target: LatLng(36.203977, 37.132782),
                              zoom: 16,
                            ),
                        markers: markers,
                        onTap: (argument) async {
                          if (index == 2) {
                            index = 0;
                            listMarkers.clear();
                            markers.clear();
                            p0.value!.clear();
                            points.clear();
                            _polygon.clear();
                          }
                          final con = await _googleMapController.future;
                          con.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(zoom: 16, target: argument)));

                          listMarkers.add(argument);
                          p0.didChange(listMarkers);
                          markers.add(
                            Marker(
                              markerId: MarkerId('${p0.value?[index]}'),
                              position: p0.value?[index] ??
                                  const LatLng(36.203977, 37.132782),
                              infoWindow: InfoWindow(
                                title: startEndPoint[index],
                              ),
                              icon: BitmapDescriptor.defaultMarker,
                            ),
                          );
                          points.add(argument);
                          _polygon.add(Polygon(
                            polygonId: const PolygonId('1'),
                            points: points,
                            fillColor: const Color(0xFF404040).withOpacity(0.3),
                            strokeColor: const Color(0xFF404040),
                            strokeWidth: 4,
                          ));

                          widget.onChanged(p0.value);

                          index++;
                        },
                        onCameraMove: (position) {
                          latitude = position.target.latitude;
                          longitude = position.target.longitude;
                        },
                        onMapCreated: (GoogleMapController controller) {
                          _googleMapController.complete(controller);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: BlocSelector<HomeBloc, HomeState, CommonState>(
                        selector: (state) =>
                            state.getState(HomeState.changeLocationEvent),
                        builder: (context, state) {
                          return AppButton.field(
                            title: S.of(context).use_current_location,
                            isLoading: state.isLoading,
                            prefixIcon: Padding(
                              padding: REdgeInsetsDirectional.only(end: 8),
                              child: AppImage.asset(
                                Assets.icons.essential.map.path,
                                color: Colors.white,
                              ),
                            ),
                            margin: EdgeInsets.only(bottom: 16.h, left: 16.w),
                            textStyle: context.textTheme.subHeadMedium,
                            onPressed: () async {
                              context.read<HomeBloc>().add(
                                  ChangeLocationEvent(onSuccess: (value) async {
                                final con = await _googleMapController.future;
                                con.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            zoom: 16, target: value)));
                              }));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ));
      },
    );
  }
}
