import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'image_place_holder.dart';

enum Source { assets, network }

class AppImage extends StatelessWidget {
  const AppImage.asset(
    this.path, {
    super.key,
    this.alignment,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.colorFilter,
    this.loadingBuilder,
    this.failedBuilder,
    this.size,
  }) : _source = Source.assets;

  const AppImage.network(
    this.path, {
    super.key,
    this.alignment,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.loadingBuilder,
    this.failedBuilder,
    this.colorFilter,
    this.size,
  }) : _source = Source.network;

  final Source _source;

  final String path;
  final Alignment? alignment;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Color? color;
  final WidgetBuilder? loadingBuilder;

  ///pass size will overwrite height and width
  final double? size;

  ///this will be ignored if the image source is [SvgPicture.network]
  final WidgetBuilder? failedBuilder;

  ///only work on svg and color will be ignore
  final ColorFilter? colorFilter;

  @override
  Widget build(BuildContext context) {
    if (path.contains('.svg')) {
      switch (_source) {
        case Source.assets:
          return SvgPicture.asset(
            path,
            colorFilter: colorFilter ?? (color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null),
            alignment: alignment ?? Alignment.center,
            fit: fit ?? BoxFit.contain,
            height: getHeight(),
            width: getWidth(),
          );
        case Source.network:
          return SvgPicture.network(
            path,
            placeholderBuilder: (context) => ImagePlaceHolder(
              width: (getWidth() ?? 50) * .8,
              height: getHeight() ?? 50,
            ),
            colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
            alignment: alignment ?? Alignment.center,
            fit: fit ?? BoxFit.contain,
            height: getHeight(),
            width: getWidth(),
          );
      }
    } else {
      switch (_source) {
        case Source.assets:
          return Image.asset(
            path,
            color: color,
            alignment: alignment ?? Alignment.center,
            fit: fit,
            height: getHeight(),
            width: getWidth(),
          );
        case Source.network:
          return CachedNetworkImage(
            imageUrl: path,
            color: color,

            errorWidget: (context, url, error) => ImagePlaceHolder(
              width: (getWidth() ?? 50) * .8,
              height: getHeight() ?? 50,
            ),
            // errorBuilder: (context, v, trace) {
            //   return ImagePlaceHolder(width:getWidth()!,height: getHeight()!, );
            // },
            // loadingBuilder: (context, child, loadingProgress) =>
            //     ImagePlaceHolder(width:getWidth()!,height: getHeight()!, ),
            placeholder: (context, url) => ImagePlaceHolder(
              width: (getWidth() ?? 50) * .8,
              height: getHeight() ?? 50,
            ),
            alignment: alignment ?? Alignment.center,
            fit: fit,
            height: getHeight(),
            width: getWidth(),
          );
      }
    }
  }

  double? getHeight() => size ?? height;

  double? getWidth() => size ?? width;

  Widget getLoadingBuilder(BuildContext context) => loadingBuilder != null
      ? loadingBuilder!(context)
      : SizedBox(
          height: getHeight(),
          width: getWidth(),
          child: const CircularProgressIndicator(strokeWidth: 1),
        );

  Widget copyWith(Color? color) {
    if (_source == Source.network) {
      return AppImage.network(
        path,
        color: color ?? this.color,
        width: width,
        height: height,
        size: size,
        alignment: alignment,
        fit: fit,
        colorFilter: colorFilter,
        failedBuilder: failedBuilder,
        loadingBuilder: loadingBuilder,
        key: key,
      );
    }
    return AppImage.asset(
      path,
      color: color ?? this.color,
      width: width,
      height: height,
      size: size,
      alignment: alignment,
      fit: fit,
      colorFilter: colorFilter,
      failedBuilder: failedBuilder,
      loadingBuilder: loadingBuilder,
      key: key,
    );
  }
}

class _LoadingImageIndicator extends StatelessWidget {
  const _LoadingImageIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(strokeWidth: 2));
  }
}
