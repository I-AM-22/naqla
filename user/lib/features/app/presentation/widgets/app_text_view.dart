//import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppTextView extends StatelessWidget {
  const AppTextView(
    String this.data, {
    Key? key,
    required this.style,
    this.translation = true,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.strutStyle,
    this.locale,
    this.overflow,
    this.textSpan,
    this.textDirection = TextDirection.LTR,
    this.textScaleFactor,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.scrollText = false,
  }) : super(key: key);

  final String? data;
  final bool translation;
  final InlineSpan? textSpan;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final Color? selectionColor;
  final bool scrollText;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      translation ? data!.tr() : data!,
      style: style,
      key: key,
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textAlign: textAlign,
      //textDirection: textDirection,
      textScaleFactor: textScaleFactor,
    );
  }
}
