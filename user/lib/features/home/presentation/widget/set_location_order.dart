import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/global_widgets/custom_text_field.dart';
import '../../../../core/util/core_helper_functions.dart';
import '../bloc/home_bloc.dart';

class SetLocationOrder extends StatefulWidget {
  const SetLocationOrder(
      {super.key,
      required this.validator,
      required this.title,
      required this.name});
  final String? Function(LatLng?)? validator;
  final String title;
  final String name;

  @override
  State<SetLocationOrder> createState() => _SetLocationOrderState();
}

class _SetLocationOrderState extends State<SetLocationOrder> {
  CameraPosition? cameraPosition;
  Set<Marker> markers = {};
  final Completer<GoogleMapController> _googleMapController = Completer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return CustomFormBuilderField<LatLng>(
            validator: widget.validator,
            name: widget.name,
            child: (p0) => Stack(
                  children: [
                    SizedBox(
                      height: 250.h,
                      child: GoogleMap(
                        key: const Key("MAP"),
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        gestureRecognizers: {
                          Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer())
                        },
                        initialCameraPosition: cameraPosition ??
                            const CameraPosition(
                              target: LatLng(36.2027687, 37.1331042),
                              zoom: 14.5,
                            ),
                        markers: markers,
                        onTap: (argument) async {
                          final con = await _googleMapController.future;
                          con.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(zoom: 16, target: argument)));

                          p0.didChange(argument);
                          markers.add(
                            Marker(
                              markerId: MarkerId(widget.name),
                              position: p0.value ??
                                  const LatLng(36.203977, 37.132782),
                              icon: BitmapDescriptor.bytes(
                                height: 40.h,
                                await CoreHelperFunctions.getBytesFromAsset(
                                    'assets/icons/png/map.png', 100),
                              ),
                              infoWindow: InfoWindow(
                                title: widget.title,
                              ),
                            ),
                          );

                          setState(() {});
                        },
                        onCameraMove: (position) async {},
                        onMapCreated: (GoogleMapController controller) {
                          _googleMapController.complete(controller);
                        },
                      ),
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   child: BlocSelector<HomeBloc, HomeState, CommonState>(
                    //     selector: (state) =>
                    //         state.getState(HomeState.changeLocationEvent),
                    //     builder: (context, state) {
                    //       return AppButton.field(
                    //         title: S.of(context).use_current_location,
                    //         isLoading: state.isLoading,
                    //         prefixIcon: Padding(
                    //           padding: REdgeInsetsDirectional.only(end: 8),
                    //           child: AppImage.asset(
                    //             Assets.icons.essential.map.path,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //         margin: EdgeInsets.only(bottom: 16.h, left: 16.w),
                    //         textStyle: context.textTheme.subHeadMedium,
                    //         onPressed: () async {
                    //           context.read<HomeBloc>().add(
                    //               ChangeLocationEvent(onSuccess: (value) async {
                    //             final con = await _googleMapController.future;
                    //             con.animateCamera(
                    //                 CameraUpdate.newCameraPosition(
                    //                     CameraPosition(
                    //                         zoom: 16, target: value)));
                    //           }));
                    //         },
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ));
      },
    );
  }
}
