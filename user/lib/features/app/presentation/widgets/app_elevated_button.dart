import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/core/config/themes/my_color_scheme.dart';
import 'package:user/core/util/extensions/build_context.dart';
import 'package:user/core/util/extensions/num.dart';
import 'package:user/core/util/theme_state.dart';
import 'package:user/features/app/presentation/widgets/app_text_view.dart';
import 'package:user/features/app/presentation/widgets/loading_indicator.dart';

import '../../../../generated/locale_keys.g.dart';

enum AppButtonStyle {
  primary,
  secondary,
}

class AppElevatedButton extends StatefulWidget {
  const AppElevatedButton({
    Key? key,
    this.onPressed,
    this.onDisabled,
    this.child,
    this.text,
    this.isLoading = false,
    this.sensitiveNetwork = false,
    this.appButtonStyle,
    this.textStyle,
    this.style,
  }) : super(key: key);

  final Function()? onPressed;
  final Function()? onDisabled;
  final Widget? child;
  final String? text;
  final bool isLoading;
  final AppButtonStyle? appButtonStyle;
  final ButtonStyle? style;
  final bool sensitiveNetwork;
  final TextStyle? textStyle;

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends ThemeState<AppElevatedButton> {
  ElevatedButtonThemeData? _buttonTheme;

  bool get absorbing => widget.onDisabled != null ? false : widget.isLoading;

  CrossFadeState get crossFadeState =>
      widget.isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst;

  Function()? get onTap =>
      widget.isLoading ? widget.onDisabled?.call() ?? () {} : widget.onPressed;

  @override
  Widget build(BuildContext context) {
    assert(() {
      if (widget.text == null && widget.child == null) {
        throw FlutterError("Can't be both text and child is null");
      }
      if (widget.style != null && widget.appButtonStyle != null) {
        throw FlutterError("Can't be pass both style and tripperButtonStyle");
      }
      return true;
    }());

    setButtonStyle();

    final child = ElevatedButton(
      onPressed: onTap,
      style: widget.style ?? _buttonTheme?.style,
      child: AnimatedCrossFade(
        firstChild: firstChild,
        secondChild: secondChild,
        duration: 300.milliseconds,
        crossFadeState: crossFadeState,
      ),
    );

    return child;
  }

  Widget get secondChild => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppTextView(
              LocaleKeys.lbl_loading,
              style: null,
            ),
            if (widget.isLoading) ...{
              8.horizontalSpace,
              const LoadingIndicator(),
              4.horizontalSpace,
            },
          ],
        ),
      );

  Widget get firstChild => FittedBox(
        fit: BoxFit.fitWidth,
        child: widget.child ??
            AppTextView(
              widget.text!.tr(),
              style: widget.textStyle,
            ),
      );

  void setButtonStyle() {
    final defaultElevatedTheme = theme.elevatedButtonTheme;

    final secondaryElevatedTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          shape: defaultElevatedTheme.style?.shape?.resolve({}),
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.onBackground,
          elevation: 0.0,
          shadowColor: colorScheme.white.withOpacity(0.1),
          textStyle: widget.textStyle,
          side: BorderSide(color: context.colorScheme.primary, width: 0.7)),
    );

    final loadingElevatedTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: defaultElevatedTheme.style?.shape?.resolve({}),
        backgroundColor: colorScheme.surfaceVariant,
        foregroundColor: colorScheme.outline,
        textStyle: widget.textStyle,
      ),
    );

    _buttonTheme = widget.isLoading
        ? loadingElevatedTheme
        : widget.appButtonStyle == AppButtonStyle.secondary
            ? secondaryElevatedTheme
            : defaultElevatedTheme;
  }
}
