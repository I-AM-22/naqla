import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/auth/presentation/pages/welcome_page.dart';
import 'package:naqla/generated/flutter_gen/assets.gen.dart';

import '../../../../generated/l10n.dart';
import '../../../../services/location_map_service.dart';

class SetLocationPage extends StatefulWidget {
  const SetLocationPage({super.key});
  static const String path = "/SetLocationPage";
  static const String name = "SetLocationPage";

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
                opacity: .7,
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
                    Assets.images.svg.placeIndicate.path,
                    width: 110.r,
                    height: 110.r,
                  ),
                  const Spacer(),
                  AppText.titleMedium(
                    S.of(context).enable_your_location,
                    textAlign: TextAlign.center,
                  ),
                  12.verticalSpace,
                  AppText.subHeadMedium(
                    S.of(context).choose_your_location_to_start,
                    textAlign: TextAlign.center,
                    color: context.colorScheme.systemGray.shade400,
                  ),
                  const Spacer(),
                  AppButton.dark(
                    stretch: true,
                    onPressed: () {
                      LocationService().getLocation();
                    },
                    title: S.of(context).use_my_location,
                  ),
                  10.verticalSpace,
                  Center(
                    child: AppButton.ghost(
                      title: S.of(context).skip_for_now,
                      textStyle: TextStyle(
                          color: context.colorScheme.systemGray.shade300),
                      onPressed: () {
                        context.goNamed(WelcomePage.name);
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
