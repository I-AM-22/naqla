import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:naqla/core/config/router/router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/generated/flutter_gen/assets.gen.dart';
import 'package:naqla/generated/locale_keys.g.dart';

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
                    LocaleKeys.welcome_enable_your_location.tr(),
                    textAlign: TextAlign.center,
                  ),
                  12.verticalSpace,
                  AppText.subHeadMedium(
                    LocaleKeys.welcome_choose_your_location.tr(),
                    textAlign: TextAlign.center,
                    color: context.colorScheme.systemGray.shade400,
                  ),
                  const Spacer(),
                  AppButton.dark(
                    stretch: true,
                    onPressed: () {
                      LocationService().getLocation();
                    },
                    title: LocaleKeys.welcome_use_my_location.tr(),
                  ),
                  10.verticalSpace,
                  Center(
                    child: AppButton.ghost(
                      title: LocaleKeys.welcome_Skip_for_now.tr(),
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
