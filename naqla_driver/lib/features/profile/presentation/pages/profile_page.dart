import 'package:flutter/material.dart';

import '../../../../core/global_widgets/app_image.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static String path = "/ProfilePage";
  static String name = "/ProfilePage";

  @override
  Widget build(BuildContext context) {
    return AppImage.asset(Assets.images.svg.noDataRafiki1.path);
  }
}
