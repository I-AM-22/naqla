import 'package:flutter/material.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/generated/l10n.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String path = "/HomePage";
  static String name = "/HomePage";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        backgroundColor: context.colorScheme.primaryContainer,
        label: AppText.labelMedium(S.of(context).add_car,
            fontWeight: FontWeight.w800),
      ),
      body: AppImage.asset(Assets.images.svg.noDataRafiki1.path),
    );
  }
}
