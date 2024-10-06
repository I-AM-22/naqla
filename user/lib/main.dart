import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/configuration/api_routes.dart';
import 'package:naqla/features/app/presentation/pages/app.dart';

import 'core/di/di_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 

  await configureDependencies();
  await ScreenUtil.ensureScreenSize();

  assert(ApiRoutes.baseUrl.isNotEmpty, 'BASE_URL is not set');
  assert(ApiRoutes.realTimeUrl.isNotEmpty, 'REAL_TIME_URL is not set');

  runApp(const App());
}
