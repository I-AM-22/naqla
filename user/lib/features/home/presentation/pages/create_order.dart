import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/core/global_widgets/custom_text_field.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/features/home/presentation/pages/order_photos_page.dart';
import 'package:naqla/generated/flutter_gen/assets.gen.dart';

import '../../../../generated/l10n.dart';

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
  Set<Marker> markers = {};
  final Completer<GoogleMapController> _googleMapController = Completer();
  List<LatLng> listMarkers = [];
  final Set<Polygon> _polygon = HashSet<Polygon>();
  List<LatLng> points = [];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final startEndPoint = [
      S.of(context).start_point,
      S.of(context).end_point,
    ];
    return BlocProvider.value(
      value: getIt<HomeBloc>(),
      child: AppScaffold(
        bottomNavigationBar: Padding(
          padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: 10),
          child: AppButton.dark(
            title: S.of(context).next,
            onPressed: () => context.pushNamed(OrderPhotosPage.name),
          ),
        ),
        appBar: AppAppBar(appBarParams: AppBarParams(title: S.of(context).new_naqla)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<HomeBloc, Map<int, CommonState>>(
                builder: (context, state) => CustomFormField<List<LatLng>>(
                    child: (p0) => Stack(
                          children: [
                            SizedBox(
                              height: 250.h,
                              child: GoogleMap(
                                key: const Key("MAP"),
                                mapType: MapType.normal,
                                zoomControlsEnabled: false,
                                polygons: _polygon,
                                gestureRecognizers: {Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())},
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
                                  con.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom: 16, target: argument)));

                                  listMarkers.add(argument);
                                  p0.didChange(listMarkers);
                                  markers.add(
                                    Marker(
                                      markerId: MarkerId('${p0.value?[index]}'),
                                      position: p0.value?[index] ?? const LatLng(36.203977, 37.132782),
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
                              child: BlocSelector<HomeBloc, Map<int, CommonState>, CommonState>(
                                selector: (state) => state[HomeState.changeLocationEvent]!,
                                builder: (context, state) {
                                  return AppButton.field(
                                    title: S.of(context).use_current_location,
                                    isLoading: state.isLoading(),
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
                                      context.read<HomeBloc>().add(ChangeLocationEvent(onSuccess: (value) async {
                                        final con = await _googleMapController.future;
                                        con.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom: 16, target: value)));
                                      }));
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        )),
              ),
              16.verticalSpace,
              Padding(
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
                child: AppTextFormField(
                  hintText: "Date",
                  prefixIcon: AppImage.asset("assets/icons/essential/current_location.svg"),
                ),
              ),
              16.verticalSpace,
              Padding(
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
                child: AppTextFormField(
                  hintText: "Time",
                  prefixIcon: AppImage.asset(
                    Assets.icons.essential.clock2.path,
                    size: 16.w,
                  ),
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
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
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
                child: AppText.bodySmMedium("الاجر سيعتمد على عدد الحمالين المطلوبين والطوابق وطبيعة الأغراض المنقولة باتفاق من الطرفين."),
              ),
              18.verticalSpace,
              Padding(
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
                child: AppText.bodySmMedium(
                  "مواصفات إضافية للسيارة:",
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: 10),
                child: ListView.separated(
                  shrinkWrap: true,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
