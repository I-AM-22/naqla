import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naqla_driver/core/core.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.color, this.size});
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitHourGlass(
      size: size ?? 50,
      color: color ?? context.colorScheme.primary,
    ));
  }
}
