import 'package:flutter/material.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:shimmer/shimmer.dart';

class ImagePlaceHolder extends StatelessWidget {
  const ImagePlaceHolder({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.primary.withOpacity(.1),
      highlightColor: Colors.grey.shade100,
      child: Center(
        child: AppText(
          'Loading',
        ),
      ),
    );
  }
}
