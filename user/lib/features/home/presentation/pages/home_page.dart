import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/core/core.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String get path => '/HomePage';
  static String get name => '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: CustomerAppBar(back: true, appBarParams: AppBarParams()),
        body: Column());
  }
}
