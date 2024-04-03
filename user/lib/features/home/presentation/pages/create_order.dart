import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/core/global_widgets/custom_text_field.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/generated/flutter_gen/assets.gen.dart';
import 'package:naqla/generated/l10n.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  static const String path = "CreateOrderPage";
  static const String name = "CreateOrderPage";

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  double? latitude, longitude;
  CameraPosition? cameraPosition;
  Set<Marker>? markers;
  final Completer<GoogleMapController> _googleMapController = Completer();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeBloc>(),
      child: AppScaffold(
        bottomNavigationBar: Padding(
          padding: REdgeInsets.symmetric(
              horizontal: UIConstants.screenPadding16, vertical: 10),
          child: AppButton.dark(
            title: "Next",
            onPressed: () {},
          ),
        ),
        appBar: AppAppBar(appBarParams: AppBarParams(title: "new naqla")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) => CustomFormField<LatLng>(
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
                                    target: LatLng(36.203977, 37.132782),
                                    zoom: 16,
                                  ),
                              markers: markers != null
                                  ? markers!
                                  : {
                                      Marker(
                                        markerId: MarkerId('${p0.value}'),
                                        position: p0.value ??
                                            const LatLng(36.203977, 37.132782),
                                        infoWindow: const InfoWindow(
                                          title: 'Your Location ',
                                        ),
                                        icon: BitmapDescriptor.defaultMarker,
                                      )
                                    },
                              onTap: (argument) async {
                                final con = await _googleMapController.future;
                                con.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            zoom: 16, target: argument)));
                                p0.didChange(argument);
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
                            child: AppButton.field(
                              title: "use current location",
                              isLoading: false,
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
                                //TODO FIX THIS
                                // context
                                //     .read<HomeBloc>()
                                //     .add(ChangeLocationEvent((value) async {
                                //   final con = await _googleMapController.future;
                                //   con.animateCamera(
                                //       CameraUpdate.newCameraPosition(
                                //           CameraPosition(
                                //               zoom: 14, target: value)));
                                //   p0.didChange(value);
                                // }));
                              },
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    color: context.colorScheme.primaryContainer,
                                    width: 1),
                              ),
                            ),
                          ),
                        ],
                      )),
            ),
            16.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(
                  horizontal: UIConstants.screenPadding16),
              child: AppTextFormField(
                hintText: "Date",
                prefixIcon: AppImage.asset(
                    "assets/icons/essential/current_location.svg"),
              ),
            ),
            16.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(
                  horizontal: UIConstants.screenPadding16),
              child: AppTextFormField(
                hintText: "Time",
                prefixIcon: AppImage.asset(
                  "assets/icons/essential/clock 2.svg",
                  size: 16.w,
                ),
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(
                  horizontal: UIConstants.screenPadding16),
              child: Row(
                children: [
                  const AppCheckbox(),
                  8.horizontalSpace,
                  AppText.bodySmMedium(
                    "حمالين",
                    color: Colors.black,
                  )
                ],
              ),
            ),
            11.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(
                  horizontal: UIConstants.screenPadding16),
              child: AppText.bodySmMedium(
                  "الاجر سيعتمد على عدد الحمالين المطلوبين والطوابق وطبيعة الأغراض المنقولة باتفاق من الطرفين."),
            ),
            18.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(
                  horizontal: UIConstants.screenPadding16),
              child: AppText.bodySmMedium(
                "مواصفات إضافية للسيارة:",
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Padding(
                padding: REdgeInsets.symmetric(
                    horizontal: UIConstants.screenPadding16, vertical: 10),
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (context, index) => 14.verticalSpace,
                  itemBuilder: (context, index) => Row(
                    children: [
                      const AppCheckbox(),
                      8.horizontalSpace,
                      AppText.bodySmMedium(
                        "حمالين",
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
