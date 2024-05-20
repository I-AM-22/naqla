import 'package:flutter/material.dart';

import '../../../../core/global_widgets/app_image.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});
  static String path = "/OrdersPage";
  static String name = "/OrdersPage";

  @override
  Widget build(BuildContext context) {
    return AppImage.asset(Assets.images.svg.noDataRafiki1.path);
  }
}
