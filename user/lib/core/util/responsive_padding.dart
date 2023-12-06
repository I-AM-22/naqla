import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension EdgeInsetsExtension on EdgeInsets {
  EdgeInsets get hw => copyWith(
        top: top.h,
        bottom: bottom.h,
        right: right.w,
        left: left.w,
      );
}

class HWPadding extends SingleChildRenderObjectWidget {
  /// Creates a adapt widget that insets its child.
  ///
  /// The [padding] argument must not be null.
  const HWPadding({
    Key? key,
    required Widget child,
    required this.padding,
  }) : super(key: key, child: child);

  /// The amount of space by which to inset the child.
  final EdgeInsets padding;

  @override
  RenderPadding createRenderObject(BuildContext context) {
    return RenderPadding(
      padding: padding is HWEdgeInsets ? padding : padding.hw,
      textDirection: Directionality.maybeOf(context),
    );
  }
}

class HWEdgeInsets extends EdgeInsets {
  /// Creates adapt insets from offsets from the left, top, right, and bottom.
  HWEdgeInsets.fromLTRB(double left, double top, double right, double bottom)
      : super.fromLTRB(left.w, top.h, right.w, bottom.h);

  /// Creates adapt insets where all the offsets are `value`.
  ///
  /// {@tool snippet}
  ///
  /// Adapt height-pixel margin on all sides:
  ///
  /// ```dart
  /// const REdgeInsets.all(8.0)
  /// ```
  /// {@end-tool}
  HWEdgeInsets.all(double value) : super.all(value.r);

  /// Creates adapt insets with symmetrical vertical and horizontal offsets.
  ///
  /// {@tool snippet}
  ///
  /// Adapt Eight pixel margin above and below, no horizontal margins:
  ///
  /// ```dart
  /// const REdgeInsets.symmetric(vertical: 8.0)
  /// ```
  /// {@end-tool}
  HWEdgeInsets.symmetric({
    double vertical = 0,
    double horizontal = 0,
  }) : super.symmetric(vertical: vertical.h, horizontal: horizontal.w);

  /// Creates adapt insets with only the given values non-zero.
  ///
  /// {@tool snippet}
  ///
  /// Adapt left margin indent of 40 pixels:
  ///
  /// ```dart
  /// const REdgeInsets.only(left: 40.0)
  /// ```
  /// {@end-tool}
  HWEdgeInsets.only({
    double bottom = 0,
    double right = 0,
    double left = 0,
    double top = 0,
  }) : super.only(
          bottom: bottom.h,
          right: right.w,
          left: left.w,
          top: top.h,
        );
}

class HWEdgeInsetsDirectional extends EdgeInsetsDirectional {
  /// Creates insets where all the offsets are `value`.
  ///
  /// {@tool snippet}
  ///
  /// Adapt eight-pixel margin on all sides:
  ///
  /// ```dart
  /// const REdgeInsetsDirectional.all(8.0)
  /// ```
  /// {@end-tool}
  HWEdgeInsetsDirectional.all(double value) : super.all(value.r);

  /// Creates insets with only the given values non-zero.
  ///
  /// {@tool snippet}
  ///
  /// Adapt margin indent of 40 pixels on the leading side:
  ///
  /// ```dart
  /// const REdgeInsetsDirectional.only(start: 40.0)
  /// ```
  /// {@end-tool}
  HWEdgeInsetsDirectional.only({
    double bottom = 0,
    double end = 0,
    double start = 0,
    double top = 0,
  }) : super.only(
          bottom: bottom.h,
          start: start.w,
          end: end.w,
          top: top.h,
        );

  /// Creates adapt insets from offsets from the start, top, end, and bottom.
  HWEdgeInsetsDirectional.fromSTEB(
    double start,
    double top,
    double end,
    double bottom,
  ) : super.fromSTEB(
          start.w,
          top.h,
          end.w,
          bottom.h,
        );
}
