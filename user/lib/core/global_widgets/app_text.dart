import 'package:flutter/cupertino.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:naqla/core/core.dart';

class AppText extends StatelessWidget {
  AppText(
    this.text, {
    super.key,
    this.strutStyle,
    this.textAlign,
    this.textDirection = TextDirection.ltr,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    TextStyle? style,
    this.color,
    this.velocity,
    this.figmaLineHeight,
    this.scrollText = false,
  }) : style = (style ?? const TextStyle()).copyWith(color: color);

  final String text;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final Color? selectionColor;
  final TextStyle? style;
  final Color? color;
  final double? velocity;
  final bool scrollText;

  final double? figmaLineHeight;

  @override
  Widget build(BuildContext context) {
    return scrollText
        ? TextScroll(
            text,
            mode: TextScrollMode.endless,
            velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
            delayBefore: const Duration(milliseconds: 1000),
            pauseBetween: const Duration(milliseconds: 2000),
            style: style?.copyWith(color: color),
            selectable: true,
            intervalSpaces: 5,
            textAlign: textAlign,
            // textDirection: textDirection,
          )
        : Text(
            text,
            style: style?.copyWith(
                color: color,
                height: (figmaLineHeight != null && style?.fontSize != null) ? figmaLineHeight?.fromFigmaHeight(style!.fontSize!) : null),
            key: key,
            locale: locale,
            maxLines: maxLines,
            overflow: overflow,
            semanticsLabel: semanticsLabel,
            softWrap: softWrap,
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
          );
  }

  ///                              <<<<<  ----    Default Style   ----  >>>>>
  AppText.displayLarge(
    this.text, {
    this.figmaLineHeight,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    this.scrollText = false,
    TextStyle? style,
    FontWeight? fontWeight,
    super.key,
  }) : style = textTheme.displayLarge?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.displayMedium(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.figmaLineHeight,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.displayMedium?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.displaySmall(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.textAlign,
    this.figmaLineHeight,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.displaySmall?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.headlineLarge(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.textAlign,
    this.figmaLineHeight,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.headlineLarge?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.headlineSmall(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.figmaLineHeight,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.headlineSmall?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.headlineMedium(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.textAlign,
    this.figmaLineHeight,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.headlineMedium?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.titleLarge(
    this.text, {
    this.scrollText = false,
    this.figmaLineHeight,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.titleLarge?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.titleMedium(
    this.text, {
    this.scrollText = false,
    this.figmaLineHeight,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.titleMedium?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.titleSmall(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.figmaLineHeight,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.titleSmall?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.labelLarge(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.figmaLineHeight,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.labelLarge?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.labelMedium(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.figmaLineHeight,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.labelMedium?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.labelSmall(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.figmaLineHeight,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.labelSmall?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.bodyLarge(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.figmaLineHeight,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.bodyLarge?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.bodyMedium(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.figmaLineHeight,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.bodyMedium?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.bodySmMedium(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.figmaLineHeight,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.bodySmMedium.merge(style).copyWith(fontWeight: fontWeight);

  AppText.bodySmall(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    this.figmaLineHeight,
    TextStyle? style,
    FontWeight? fontWeight,
    super.key,
  }) : style = textTheme.bodySmall?.merge(style).copyWith(fontWeight: fontWeight);

  AppText.buttonText(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.textAlign,
    this.textDirection = TextDirection.ltr,
    this.locale,
    this.figmaLineHeight,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.subHeadWebMedium.merge(style).copyWith(fontWeight: fontWeight);

  AppText.bodyRegular(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.figmaLineHeight,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.bodyRegular.merge(style).copyWith(fontWeight: fontWeight);

  AppText.subHeadMedium(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.figmaLineHeight,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.subHeadMedium.merge(style).copyWith(fontWeight: fontWeight);

  AppText.subHeadRegular(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.figmaLineHeight,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.subHeadRegular.merge(style).copyWith(fontWeight: fontWeight);

  AppText.subHeadWebMedium(
    this.text, {
    this.scrollText = false,
    this.strutStyle,
    this.figmaLineHeight,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.velocity,
    super.key,
    TextStyle? style,
    FontWeight? fontWeight,
  }) : style = textTheme.subHeadWebMedium.merge(style).copyWith(fontWeight: fontWeight);

  copyWith({Color? color}) => AppText(
        text,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        selectionColor: selectionColor,
        style: style,
        color: color ?? this.color,
        velocity: velocity,
        figmaLineHeight: figmaLineHeight,
        scrollText: scrollText,
      );
}
