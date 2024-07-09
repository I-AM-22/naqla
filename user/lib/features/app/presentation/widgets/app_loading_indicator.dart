import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naqla/core/core.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.size, this.color});
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitHourGlass(
      color: color ?? context.colorScheme.primary,
      size: size ?? 50,
    ));
  }
}
