import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SvgSource {
  assets,
  network,
  string,
}

class AppSvgPicture extends StatelessWidget {
  final String svgPath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final AlignmentGeometry? alignment;
  final SvgSource? stateType;

  const AppSvgPicture(
    this.svgPath, {
    Key? key,
    this.stateType = SvgSource.assets,
    this.alignment,
    this.width,
    this.height,
    this.fit,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return stateType == SvgSource.assets
        ? (isSvg
            ? SvgPicture.asset(
                svgPath,
                width: width,
                height: height,
                alignment: alignment ?? Alignment.center,
                fit: fit ?? BoxFit.contain,
              )
            : Image.asset(
                svgPath,
                width: width,
                height: height,
                color: color,
                alignment: alignment ?? Alignment.center,
                fit: fit ?? BoxFit.contain,
              ))
        : stateType == SvgSource.network
            ? SvgPicture.network(
                svgPath,
                width: width,
                height: height,
                alignment: alignment ?? Alignment.center,
                fit: fit ?? BoxFit.contain,
              )
            : SvgPicture.string(
                svgPath,
                width: width,
                height: height,
                alignment: alignment ?? Alignment.center,
                fit: fit ?? BoxFit.contain,
              );
  }

  bool get isSvg => svgPath.contains('svg');
}
