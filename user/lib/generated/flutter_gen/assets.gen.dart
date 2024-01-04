/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  $AssetsIconsArrowGen get arrow => const $AssetsIconsArrowGen();
  $AssetsIconsEssentialGen get essential => const $AssetsIconsEssentialGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesJpgGen get jpg => const $AssetsImagesJpgGen();
  $AssetsImagesSvgsGen get svgs => const $AssetsImagesSvgsGen();
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/car_1.json
  LottieGenImage get car1 => const LottieGenImage('assets/lottie/car_1.json');

  /// File path: assets/lottie/car_2.json
  LottieGenImage get car2 => const LottieGenImage('assets/lottie/car_2.json');

  /// File path: assets/lottie/car_3.json
  LottieGenImage get car3 => const LottieGenImage('assets/lottie/car_3.json');

  /// File path: assets/lottie/car_4.json
  LottieGenImage get car4 => const LottieGenImage('assets/lottie/car_4.json');

  /// File path: assets/lottie/car_5.json
  LottieGenImage get car5 => const LottieGenImage('assets/lottie/car_5.json');

  /// List of all assets
  List<LottieGenImage> get values => [car1, car2, car3, car4, car5];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
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

  /// File path: assets/icons/essential/About Us.svg
  SvgGenImage get aboutUs =>
      const SvgGenImage('assets/icons/essential/About Us.svg');

  /// File path: assets/icons/essential/More.svg
  SvgGenImage get more => const SvgGenImage('assets/icons/essential/More.svg');

  /// File path: assets/icons/essential/check circle.svg
  SvgGenImage get checkCircle =>
      const SvgGenImage('assets/icons/essential/check circle.svg');

  /// File path: assets/icons/essential/map.svg
  SvgGenImage get map => const SvgGenImage('assets/icons/essential/map.svg');

  /// File path: assets/icons/essential/plus.svg
  SvgGenImage get plus => const SvgGenImage('assets/icons/essential/plus.svg');

  /// List of all assets
  List<SvgGenImage> get values => [aboutUs, more, checkCircle, map, plus];
}

class $AssetsImagesJpgGen {
  const $AssetsImagesJpgGen();

  /// File path: assets/images/jpg/map background.jpg
  AssetGenImage get mapBackground =>
      const AssetGenImage('assets/images/jpg/map background.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [mapBackground];
}

class $AssetsImagesSvgsGen {
  const $AssetsImagesSvgsGen();

  /// File path: assets/images/svgs/No data-rafiki 1.svg
  SvgGenImage get noDataRafiki1 =>
      const SvgGenImage('assets/images/svgs/No data-rafiki 1.svg');

  /// File path: assets/images/svgs/Place Indicate.svg
  SvgGenImage get placeIndicate =>
      const SvgGenImage('assets/images/svgs/Place Indicate.svg');

  /// File path: assets/images/svgs/Welcome Screen.svg
  SvgGenImage get welcomeScreen =>
      const SvgGenImage('assets/images/svgs/Welcome Screen.svg');

  /// File path: assets/images/svgs/arabic.svg
  SvgGenImage get arabic => const SvgGenImage('assets/images/svgs/arabic.svg');

  /// File path: assets/images/svgs/english.svg
  SvgGenImage get english =>
      const SvgGenImage('assets/images/svgs/english.svg');

  /// File path: assets/images/svgs/flag.svg
  SvgGenImage get flag => const SvgGenImage('assets/images/svgs/flag.svg');

  /// File path: assets/images/svgs/map background.svg
  SvgGenImage get mapBackground =>
      const SvgGenImage('assets/images/svgs/map background.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        noDataRafiki1,
        placeIndicate,
        welcomeScreen,
        arabic,
        english,
        flag,
        mapBackground
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
  const SvgGenImage(this._assetName);

  final String _assetName;

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
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
