import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/util/core_helper_functions.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/profile/presentation/pages/cars_page.dart';
import 'package:naqla_driver/features/profile/presentation/widgets/profile_item.dart';

import '../../../../core/global_widgets/app_image.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static String path = "/ProfilePage";
  static String name = "/ProfilePage";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(title: S.of(context).profile),
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: UIConstants.screenPadding30),
          child: Column(
            children: [
              ProfileItem(
                title: S.of(context).cars,
                prefixIcon: const Icon(Icons.car_crash_outlined),
                onTap: () {
                  context.pushNamed(CarsPage.name);
                },
              ),
              16.verticalSpace,
              ProfileItem(
                title: S.of(context).logOut,
                prefixIcon: const Icon(IconlyBroken.logout),
                onTap: () {
                  CoreHelperFunctions.logOut(context);
                },
              ),
              16.verticalSpace,
            ],
          ),
        ));
  }
}
