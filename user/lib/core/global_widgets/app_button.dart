import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_loading_indicator.dart';

import '../../generated/l10n.dart';

///enum
enum ButtonSize {
  ///56
  xl,

  ///48
  large,

  ///40
  medium,

  ///32
  small
}

enum FocusedFilledButtonType { border, hideBackgroundColor, hover, none }

enum AppButtonType {
  field,
  secondary,
  tertiary,
  ghost,
  light,
  dark,
  gray,
}

///Type NamedConstructor
class AppButton extends StatefulWidget {
  const AppButton.light({
    this.textStyle,
    this.buttonSize = ButtonSize.large,
    this.onPressed,
    this.child,
    this.mainAxisAlignment,
    this.title,
    this.borderRadius,
    this.padding,
    this.stretch = false,
    super.key,
    this.style,
    this.fixedSize,
    this.margin,
    this.isLoading = false,
  })  : _typeButton = AppButtonType.light,
        spaceBetweenItem = 0,
        postfixIcon = null,
        prefixIcon = null,
        focusedFilledType = FocusedFilledButtonType.none;

  const AppButton.dark({
    this.textStyle,
    this.buttonSize = ButtonSize.large,
    this.onPressed,
    this.child,
    this.stretch = false,
    this.mainAxisAlignment,
    this.title,
    this.borderRadius,
    this.padding,
    super.key,
    this.style,
    this.fixedSize,
    this.margin,
    this.isLoading = false,
  })  : _typeButton = AppButtonType.dark,
        spaceBetweenItem = 0,
        postfixIcon = null,
        prefixIcon = null,
        focusedFilledType = FocusedFilledButtonType.none;

  const AppButton.gray({
    this.textStyle,
    this.buttonSize = ButtonSize.large,
    this.onPressed,
    this.child,
    this.mainAxisAlignment,
    this.title,
    this.borderRadius,
    this.padding,
    super.key,
    this.style,
    this.fixedSize,
    this.stretch = false,
    this.isLoading = false,
    this.margin,
  })  : _typeButton = AppButtonType.gray,
        spaceBetweenItem = 0,
        postfixIcon = null,
        prefixIcon = null,
        focusedFilledType = FocusedFilledButtonType.none;

  const AppButton.field({
    this.textStyle,
    this.buttonSize = ButtonSize.medium,
    this.onPressed,
    this.child,
    this.mainAxisAlignment,
    this.title,
    this.borderRadius,
    this.padding,
    this.stretch = false,
    this.prefixIcon,
    this.postfixIcon,
    super.key,
    this.spaceBetweenItem = 8,
    this.style,
    this.fixedSize,
    this.focusedFilledType = FocusedFilledButtonType.border,
    this.margin,
    this.isLoading = false,
  }) : _typeButton = AppButtonType.field;

  const AppButton.secondary({
    this.textStyle,
    this.buttonSize = ButtonSize.medium,
    this.onPressed,
    this.child,
    this.title,
    this.stretch = false,
    this.borderRadius,
    this.prefixIcon,
    this.mainAxisAlignment,
    this.postfixIcon,
    super.key,
    this.spaceBetweenItem = 8,
    this.padding,
    this.style,
    this.fixedSize,
    this.margin,
    this.isLoading = false,
  })  : _typeButton = AppButtonType.secondary,
        focusedFilledType = FocusedFilledButtonType.none;

  const AppButton.tertiary({
    this.textStyle,
    this.stretch = false,
    this.buttonSize = ButtonSize.medium,
    this.onPressed,
    this.borderRadius,
    this.child,
    this.title,
    this.spaceBetweenItem = 8,
    this.mainAxisAlignment,
    this.prefixIcon,
    this.postfixIcon,
    this.padding,
    super.key,
    this.style,
    this.fixedSize,
    this.focusedFilledType = FocusedFilledButtonType.none,
    this.margin,
    this.isLoading = false,
  }) : _typeButton = AppButtonType.tertiary;

  const AppButton.ghost({
    this.textStyle,
    this.buttonSize = ButtonSize.medium,
    this.onPressed,
    this.borderRadius,
    this.stretch = false,
    this.child,
    this.padding,
    this.spaceBetweenItem = 8,
    this.title,
    this.mainAxisAlignment,
    super.key,
    this.prefixIcon,
    this.postfixIcon,
    this.style,
    this.fixedSize,
    this.margin,
    this.isLoading = false,
  })  : _typeButton = AppButtonType.ghost,
        focusedFilledType = FocusedFilledButtonType.none;

  ///Button Parameter
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  ///Custom Parameter
  final bool isLoading;
  final BorderRadiusGeometry? borderRadius;
  final ButtonSize buttonSize;
  final Widget? child;
  final Widget? prefixIcon;
  final Widget? postfixIcon;
  final String? title;
  final TextStyle? textStyle;
  final AppButtonType _typeButton;
  final EdgeInsetsGeometry? padding;
  final EdgeInsets? margin;
  final double spaceBetweenItem;
  final FocusedFilledButtonType focusedFilledType;

  final bool stretch;

  ///pass this will ignore [buttonSize]
  final Size? fixedSize;

  ///this will be ignore when the [postfixIcon] && [prefixIcon] is null
  final MainAxisAlignment? mainAxisAlignment;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  late final ValueNotifier<Color?> _overlayPostPrefixIconColor;
  late final ValueNotifier<Color?> _overlayTextColor;

  CrossFadeState get crossFadeState =>
      widget.isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst;

  @override
  void initState() {
    super.initState();
    _overlayPostPrefixIconColor = ValueNotifier<Color?>(getIconColor);
    _overlayTextColor = ValueNotifier<Color?>(null);
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.child != null || widget.title != null);
    switch (widget._typeButton) {
      case AppButtonType.secondary:
      case AppButtonType.field:
        return GestureDetector(
          onTapDown: onTapDown,
          onTapUp: onTapUp,
          onTapCancel: () => onTapUp(null),
          child: Padding(
            padding: getMargin,
            child: ElevatedButton(
              onPressed: getOnPressed(widget.onPressed),
              style: getButtonStyle(context),
              child: getChildButton(context),
            ),
          ),
        );
      case AppButtonType.tertiary:
        return GestureDetector(
          onTapDown: onTapDown,
          onTapUp: onTapUp,
          onTapCancel: () => onTapUp(null),
          child: Padding(
            padding: getMargin,
            child: OutlinedButton(
              onPressed: getOnPressed(widget.onPressed),
              style: getButtonStyle(context),
              child: getChildButton(context),
            ),
          ),
        );
      case AppButtonType.ghost:
        return Padding(
          padding: getMargin,
          child: TextButton(
            onPressed: getOnPressed(widget.onPressed),
            style: getButtonStyle(context),
            child: getChildButton(context),
          ),
        );

      case AppButtonType.light:
      case AppButtonType.dark:
      case AppButtonType.gray:
        return Container(
          height: sizeButton.height,
          margin: getMargin,
          decoration: BoxDecoration(
            borderRadius: getBorderRadius,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 2.r,
                color: const Color(0x0D101828),
              ),
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4.r,
                color: const Color(0x29FFFFFF),
              ),
            ],
            color: _isGray ? const Color(0xffF9FAFB) : null,
            border: getSide({}) != null
                ? Border.fromBorderSide(getSide({})!)
                : null,
          ),
          child: ElevatedButton(
            onPressed: getOnPressed(widget.onPressed),
            style: getButtonStyle(context),
            child: getChildButton(context),
          ),
        );
    }
  }

  Color? get getIconColor {
    switch (widget._typeButton) {
      case AppButtonType.secondary:
      case AppButtonType.field:
        return Colors.white;
      //todo refactor colors
      case AppButtonType.tertiary:
      case AppButtonType.ghost:
      case AppButtonType.light:
      case AppButtonType.dark:
      case AppButtonType.gray:
        return null;
    }
  }

  void onTapUp(_) {
    if (_isTertiary &&
        widget.focusedFilledType == FocusedFilledButtonType.hover) {
      _overlayTextColor.value = _oldTextColor;

      _overlayPostPrefixIconColor.value = _oldIconColor;
    } else if (_isTertiary) {
      _overlayPostPrefixIconColor.value = _oldIconColor;
    }
    if (widget._typeButton == AppButtonType.field &&
        widget.focusedFilledType ==
            FocusedFilledButtonType.hideBackgroundColor) {
      _overlayPostPrefixIconColor.value = context.colorScheme.surface;
    }
  }

  ///save postfix icon color to use it when change color if icon when focused
  Color? _oldIconColor;
  Color? _oldTextColor;

  void onTapDown(_) {
    if (_isTertiary &&
        widget.focusedFilledType == FocusedFilledButtonType.hover) {
      _overlayTextColor.value = context.colorScheme.onPrimary;
      _overlayPostPrefixIconColor.value = context.colorScheme.onPrimary;
    } else if (_isTertiary) {
      _overlayPostPrefixIconColor.value = context.colorScheme.onSurface;
    }
    if (widget._typeButton == AppButtonType.field &&
        widget.focusedFilledType ==
            FocusedFilledButtonType.hideBackgroundColor) {
      _overlayPostPrefixIconColor.value = context.colorScheme.onSurface;
    }
  }

  EdgeInsets get getMargin => widget.margin ?? EdgeInsets.zero;

  bool get isDisabled => widget.onPressed != null;

  Color? get backGroundColor {
    ///if the type is secondary should pass only color

    return null;
  }

  bool get hasIcon => widget.prefixIcon != null || widget.postfixIcon != null;

  Widget getChildButton(BuildContext context) {
    final Widget buttonChild = widget.child ??
        AppText(
          widget.title!,
          style: getTextStyle(context),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
    if (widget.isLoading) {
      return FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLoadingIndicator(),
            8.horizontalSpace,
            AppText.titleMedium(S.of(context).loading),
            4.horizontalSpace,
          ],
        ),
      );
    }
    if (hasIcon) {
      //todo separate postfix icon and prefix icon to  different color
      if (widget.postfixIcon is AppImage && _oldIconColor == null) {
        _oldIconColor = (widget.postfixIcon as AppImage).color;
      }
      if (buttonChild is AppText && _oldTextColor == null) {
        _oldTextColor = (buttonChild).color;
      }
      return ValueListenableBuilder(
          valueListenable: _overlayPostPrefixIconColor,
          builder: (context, val, child) {
            return Row(
              mainAxisSize:
                  widget.stretch ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment:
                  widget.mainAxisAlignment ?? MainAxisAlignment.center,
              children: [
                if (widget.prefixIcon != null) ...[
                  if (widget.spaceBetweenItem != 0)
                    widget.spaceBetweenItem.horizontalSpace,
                  if ((_isTertiary || _isField) &&
                      widget.prefixIcon is AppImage)
                    (widget.prefixIcon! as AppImage).copyWith(val)
                  else
                    widget.prefixIcon!
                ],
                if (_isTertiary &&
                    widget.focusedFilledType == FocusedFilledButtonType.hover &&
                    buttonChild is AppText)
                  buttonChild.copyWith(color: _overlayTextColor.value)
                else
                  buttonChild,
                if (widget.postfixIcon != null) ...[
                  if (widget.spaceBetweenItem != 0)
                    widget.spaceBetweenItem.horizontalSpace,
                  if ((_isTertiary || _isField) &&
                      widget.postfixIcon is AppImage)
                    (widget.postfixIcon! as AppImage).copyWith(val)
                  else
                    widget.postfixIcon!
                ]
              ],
            );
          });
    }

    return buttonChild;
  }

  TextStyle getTextStyle(BuildContext context) {
    if (widget.textStyle != null) return widget.textStyle!;
    if (_isLongerButton) {
      if (_isDark) {
        return context.textTheme.subHeadWebMedium.copyWith(color: Colors.white);
      }
      return context.textTheme.bodySmMedium;
    }
    return textTheme.subHeadWebMedium
        .merge(widget.textStyle ?? const TextStyle());
  }

  bool get _isTertiary => widget._typeButton == AppButtonType.tertiary;

  bool get _isField => widget._typeButton == AppButtonType.field;

  bool get _isLight => widget._typeButton == AppButtonType.light;

  bool get _isDark => widget._typeButton == AppButtonType.dark;

  bool get _isGray => widget._typeButton == AppButtonType.gray;

  bool get _isLongerButton =>
      widget._typeButton == AppButtonType.light ||
      widget._typeButton == AppButtonType.dark ||
      widget._typeButton == AppButtonType.gray;

  Color? getEnabledColor(BuildContext context) {
    if (widget._typeButton == AppButtonType.field) {
      return context.colorScheme.onPrimary;
    }
    if (widget._typeButton == AppButtonType.secondary) {
      return context.colorScheme.onSurface;
    }
    if (_isTertiary) {
      return context.colorScheme.onSurface;
    }
    if (widget._typeButton == AppButtonType.ghost) {
      return context.colorScheme.onSurface;
    }
    return null;
  }

  Size get sizeButton {
    if (widget.fixedSize != null) return widget.fixedSize!;

    switch (widget.buttonSize) {
      case ButtonSize.xl:
        return Size.fromHeight(56.h);
      case ButtonSize.large:
        return Size.fromHeight(48.h);
      case ButtonSize.medium:
        return Size.fromHeight(40.h);
      case ButtonSize.small:
        return Size.fromHeight(32.h);
    }
  }

  BorderSide? getSide(Set<WidgetState> states) {
    if (_isTertiary &&
        states.contains(WidgetState.pressed) &&
        widget.focusedFilledType == FocusedFilledButtonType.hover) {
      return BorderSide.none;
    } else if (_isTertiary && states.contains(WidgetState.pressed)) {
      return BorderSide(
        color: context.colorScheme.onSurface,
        width: 2.r,
      );
    }
    if (_isTertiary && !isDisabled) {
      ///todo change this
      return BorderSide(color: Colors.grey.shade300);
    }

    if (widget._typeButton == AppButtonType.field &&
        // widget.focusedFilledType == FocusedFilledButtonType.border &&
        states.contains(WidgetState.pressed)) {
      return BorderSide(
        color: context.colorScheme.onSurface,
        width: 2.r,
      );
    }
    if (_isLight) {
      return BorderSide(color: context.colorScheme.primary, width: 1.r);
    }

    if (_isGray) {
      return BorderSide(color: context.colorScheme.primary, width: 1.r);
    }
    return null;
  }

  Function()? getOnPressed(void Function()? onPressed) {
    if (widget.isLoading) return null;

    return onPressed;
  }

  ButtonStyle getButtonStyle(BuildContext context) {
    ButtonStyle buttonStyle = widget.isLoading
        ? ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => context.colorScheme.systemGray.shade300,
            ),
            overlayColor: WidgetStateProperty.resolveWith(
              (states) => Colors.transparent,
            ),
            shadowColor: WidgetStateProperty.all(Colors.transparent),
            surfaceTintColor: WidgetStateProperty.resolveWith(
              (states) => Colors.transparent,
            ))
        : widget.style ??
            ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  var pressed = states.contains(WidgetState.pressed);
                  if (widget.isLoading) {
                    return context.colorScheme.systemGray.shade300;
                  }

                  if (_isField &&
                      pressed &&
                      widget.focusedFilledType ==
                          FocusedFilledButtonType.hideBackgroundColor) {
                    return context.colorScheme.surface;
                  }
                  if (_isField) {
                    return context.colorScheme.primary;
                  }
                  if (_isTertiary &&
                      pressed &&
                      widget.focusedFilledType ==
                          FocusedFilledButtonType.hover) {
                    return context.colorScheme.primary;
                  }

                  if (_isTertiary && pressed) {
                    return context.colorScheme.surface;
                  }
                  if (_isLight) {
                    return Colors.transparent;
                  }
                  if (_isGray) {
                    return const Color(0xffF9FAFB);
                  }

                  return null;
                }),
                shape: _isLongerButton
                    ? null
                    : WidgetStateProperty.resolveWith((states) {
                        return getShape(states);
                      }),
                overlayColor: WidgetStateProperty.resolveWith((states) {
                  var selected = states.contains(WidgetState.pressed);
                  if (selected &&
                      _isTertiary &&
                      widget.focusedFilledType ==
                          FocusedFilledButtonType.hover) {
                    return context.colorScheme.primary;
                  }

                  if (selected && _isTertiary) {
                    return context.colorScheme.surface;
                  }
                  if (_isField &&
                      widget.focusedFilledType ==
                          FocusedFilledButtonType.hideBackgroundColor) {
                    return context.colorScheme.surface;
                  }

                  if (_isLight || _isDark || _isGray) {
                    return Colors.transparent;
                  }
                  return null;
                }),
                shadowColor: WidgetStateProperty.all(Colors.transparent),
                side: _isLongerButton
                    ? null
                    : WidgetStateProperty.resolveWith(
                        (states) => getSide(states)),
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  ///to text
                  var pressed = states.contains(WidgetState.pressed);
                  if (pressed &&
                      _isField &&
                      widget.focusedFilledType ==
                          FocusedFilledButtonType.hideBackgroundColor) {
                    return context.colorScheme.onSurface;
                  }
                  if (pressed &&
                      _isTertiary &&
                      widget.focusedFilledType ==
                          FocusedFilledButtonType.hover) {
                    return context.colorScheme.onPrimary;
                  }

                  if (pressed && _isTertiary) {
                    return context.colorScheme.onSurface;
                  }

                  if (_isLight && pressed) {
                    return context.colorScheme.primary;
                  }
                  if (_isLight) {
                    return context.colorScheme.primary;
                  }
                  if (pressed && _isDark) {
                    return context.colorScheme.primary;
                  }

                  if (_isDark) {
                    return context.colorScheme.surface;
                  }
                  if (pressed && _isGray) {
                    return context.colorScheme.systemGray.shade400;
                  }
                  if (_isGray) {
                    return context.colorScheme.primary;
                  }

                  return getEnabledColor(context);
                }),
                surfaceTintColor: WidgetStateProperty.resolveWith((states) {
                  var pressed = states.contains(WidgetState.pressed);
                  if (_isLongerButton && pressed) {
                    return Colors.transparent;
                  }
                  return null;
                }));

    switch (widget._typeButton) {
      case AppButtonType.field:
        return buttonStyle.merge(ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          fixedSize: sizeButton,
          padding: getPadding,
        ));
      case AppButtonType.secondary:
        return buttonStyle.merge(ElevatedButton.styleFrom(
          fixedSize: sizeButton,
          backgroundColor: context.colorScheme.secondary,
          elevation: 0,
          padding: getPadding,
        ));
      case AppButtonType.tertiary:
        return buttonStyle.merge(OutlinedButton.styleFrom(
          fixedSize: sizeButton,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 0,
          padding: getPadding,
        ));
      case AppButtonType.ghost:
        return buttonStyle.merge(TextButton.styleFrom(
          alignment: AlignmentDirectional.centerStart,
          fixedSize: sizeButton,
          elevation: 0,
          padding: getPadding,
          // foregroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.4),
        ));
      case AppButtonType.light:
        return buttonStyle.merge(ElevatedButton.styleFrom(
          alignment: AlignmentDirectional.center,
          fixedSize: sizeButton,
          shadowColor: Colors.transparent,
          elevation: 0,
          padding: getPadding,
          // foregroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.4),
        ));
      case AppButtonType.dark:
        return buttonStyle.merge(ElevatedButton.styleFrom(
          alignment: AlignmentDirectional.center,
          fixedSize: sizeButton,
          elevation: 0,
          padding: getPadding,
          // foregroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.4),
        ));
      case AppButtonType.gray:
        return buttonStyle.merge(ElevatedButton.styleFrom(
          alignment: AlignmentDirectional.center,
          fixedSize: sizeButton,
          elevation: 0,
          padding: getPadding,
          // foregroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.4),
        ));
    }
  }

  RoundedRectangleBorder? getShape(Set<WidgetState> states) {
    return getBorderRadius != null
        ? RoundedRectangleBorder(
            borderRadius: getBorderRadius!,
            side: getSide(states) ?? BorderSide.none)
        : null;
  }

  BorderRadiusGeometry? get getBorderRadius =>
      widget.borderRadius ?? BorderRadius.circular(8.r);

  EdgeInsetsGeometry get getPadding {
    if (widget.padding != null) {
      return widget.padding!;
    }
    if (_isLongerButton) {
      return EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w);
    }

    return EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w);
  }
}
