import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/features/app/presentation/pages/app.dart';

import 'core/di/di_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  await ScreenUtil.ensureScreenSize();
  runApp(const App());
}
