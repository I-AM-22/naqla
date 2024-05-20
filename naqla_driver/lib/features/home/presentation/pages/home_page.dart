import 'package:flutter/material.dart';
import 'package:naqla_driver/core/core.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String path = "/HomePage";
  static String name = "/HomePage";

  @override
  Widget build(BuildContext context) {
    return AppImage.asset(Assets.images.svg.noDataRafiki1.path);
  }
}
