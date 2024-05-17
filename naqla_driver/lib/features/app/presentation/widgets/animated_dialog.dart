import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';

class AnimatedDialog extends StatelessWidget {
  const AnimatedDialog._({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.elevation,
    required this.insetAnimationDuration,
    required this.insetAnimationCurve,
    this.insetPadding,
    required this.clipBehavior,
    this.shape,
    this.alignment,
  }) : super(key: key);

  final Widget child;
  final Color? backgroundColor;
  final double? elevation;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final EdgeInsets? insetPadding;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final AlignmentGeometry? alignment;
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    RouteTransitionsBuilder? transitionBuilder,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    bool barrierDismissible = false,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Color? backgroundColor,
    double? elevation,
    Duration insetAnimationDuration = const Duration(milliseconds: 100),
    Curve insetAnimationCurve = Curves.decelerate,
    EdgeInsets? insetPadding,
    Clip clipBehavior = Clip.none,
    ShapeBorder? shape,
    AlignmentGeometry? alignment,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          SafeArea(
        child: AnimatedDialog._(
          backgroundColor: context.colorScheme.onPrimary,
          alignment: alignment,
          clipBehavior: clipBehavior,
          elevation: elevation,
          insetAnimationCurve: insetAnimationCurve,
          insetAnimationDuration: insetAnimationDuration,
          insetPadding: insetPadding ?? REdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
          shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(16).r),
          child: child,
        ),
      ),
      transitionDuration: const Duration(milliseconds: 400),
      anchorPoint: anchorPoint,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      routeSettings: routeSettings,
      transitionBuilder: transitionBuilder,
      useRootNavigator: useRootNavigator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Dialog(
        backgroundColor: backgroundColor ?? context.colorScheme.onPrimary,
        alignment: alignment,
        clipBehavior: clipBehavior,
        elevation: elevation,
        insetAnimationCurve: insetAnimationCurve,
        insetAnimationDuration: insetAnimationDuration,
        insetPadding: insetPadding,
        // surfaceTintColor: backgroundColor ?? context.colorScheme.background,
        shape: shape,
        child: child,
      ),
    );
  }
}
