/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/arrow
  $AssetsIconsArrowGen get arrow => const $AssetsIconsArrowGen();

  /// Directory path: assets/icons/essential
  $AssetsIconsEssentialGen get essential => const $AssetsIconsEssentialGen();

  /// Directory path: assets/icons/flags
  $AssetsIconsFlagsGen get flags => const $AssetsIconsFlagsGen();

  /// Directory path: assets/icons/png
  $AssetsIconsPngGen get png => const $AssetsIconsPngGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/jpg
  $AssetsImagesJpgGen get jpg => const $AssetsImagesJpgGen();

  /// Directory path: assets/images/svg
  $AssetsImagesSvgGen get svg => const $AssetsImagesSvgGen();
}

class $AssetsIconsArrowGen {
  const $AssetsIconsArrowGen();

  /// File path: assets/icons/arrow/Down Arrow.svg
  SvgGenImage get downArrow =>
      const SvgGenImage('assets/icons/arrow/Down Arrow.svg');

  /// File path: assets/icons/arrow/Left Arrow.svg
  SvgGenImage get leftArrow =>
      const SvgGenImage('assets/icons/arrow/Left Arrow.svg');

  /// File path: assets/icons/arrow/Right Arrow.svg
  SvgGenImage get rightArrow =>
      const SvgGenImage('assets/icons/arrow/Right Arrow.svg');

  /// File path: assets/icons/arrow/Up Arrow.svg
  SvgGenImage get upArrow =>
      const SvgGenImage('assets/icons/arrow/Up Arrow.svg');

  /// List of all assets
  List<SvgGenImage> get values => [downArrow, leftArrow, rightArrow, upArrow];
}

class $AssetsIconsEssentialGen {
  const $AssetsIconsEssentialGen();

  /// File path: assets/icons/essential/check circle.svg
  SvgGenImage get checkCircle =>
      const SvgGenImage('assets/icons/essential/check circle.svg');

  /// File path: assets/icons/essential/check-circle2.svg
  SvgGenImage get checkCircle2 =>
      const SvgGenImage('assets/icons/essential/check-circle2.svg');

  /// File path: assets/icons/essential/website.svg
  SvgGenImage get website =>
      const SvgGenImage('assets/icons/essential/website.svg');

  /// List of all assets
  List<SvgGenImage> get values => [checkCircle, checkCircle2, website];
}

class $AssetsIconsFlagsGen {
  const $AssetsIconsFlagsGen();

  /// File path: assets/icons/flags/english.svg
  SvgGenImage get english =>
      const SvgGenImage('assets/icons/flags/english.svg');

  /// File path: assets/icons/flags/syria.jpg
  AssetGenImage get syria =>
      const AssetGenImage('assets/icons/flags/syria.jpg');

  /// List of all assets
  List<dynamic> get values => [english, syria];
}

class $AssetsIconsPngGen {
  const $AssetsIconsPngGen();

  /// File path: assets/icons/png/map.png
  AssetGenImage get map => const AssetGenImage('assets/icons/png/map.png');

  /// List of all assets
  List<AssetGenImage> get values => [map];
}

class $AssetsImagesJpgGen {
  const $AssetsImagesJpgGen();

  /// File path: assets/images/jpg/logo.jpg
  AssetGenImage get logo => const AssetGenImage('assets/images/jpg/logo.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [logo];
}

class $AssetsImagesSvgGen {
  const $AssetsImagesSvgGen();

  /// File path: assets/images/svg/No data-rafiki 1.svg
  SvgGenImage get noDataRafiki1 =>
      const SvgGenImage('assets/images/svg/No data-rafiki 1.svg');

  /// List of all assets
  List<SvgGenImage> get values => [noDataRafiki1];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final BytesLoader loader;
    if (_isVecFormat) {
      loader = AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
