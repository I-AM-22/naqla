import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/home/presentation/pages/add_car_page.dart';
import 'package:naqla_driver/generated/l10n.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String path = "/HomePage";
  static String name = "/HomePage";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        appBarParams: AppBarParams(title: S.of(context).home),
        back: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(AddCarPage.name);
        },
        icon: const Icon(
          IconlyBroken.plus,
          color: Colors.white,
        ),
        backgroundColor: context.colorScheme.primary,
        label: AppText.labelMedium(
          S.of(context).add_car,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      body: AppImage.asset(Assets.images.svg.noDataRafiki1.path),
    );
  }
}
