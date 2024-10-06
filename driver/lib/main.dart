import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/common/constants/configuration/api_routes.dart';
import 'package:naqla_driver/features/app/presentation/pages/app.dart';

import 'core/di/di_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await configureDependencies();

  assert(ApiRoutes.baseUrl.isNotEmpty, 'BASE URL is not set');
  assert(ApiRoutes.realTimeUrl.isNotEmpty, 'REAL TIME URL is not set');

  runApp(const App());
}
