import 'package:flutter/material.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key, required this.imagePath});
  final String imagePath;

  static String path = "ImagePage";
  static String name = "ImagePage";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(),
        ),
        body: Center(
          child: AppImage.network(
            imagePath,
            fit: BoxFit.contain,
          ),
        ));
  }
}
