import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    this.controller,
    this.initialValue,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textCapitalization,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign,
    this.textAlignVertical,
    this.autofocus,
    this.readOnly,
    this.showCursor,
    this.obscuringCharacter,
    this.obscureText,
    this.autocorrect,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions,
    this.maxLengthEnforcement,
    this.minLines,
    this.expands,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.mouseCursor,
    this.contextMenuBuilder,
    this.magnifierConfiguration,
    this.dragStartBehavior,
    this.contentInsertionConfiguration,
    this.description,
    this.label,
    this.suffixIcon,
    this.title,
    this.name,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.border,
    this.fillColor,
    this.enabled = true,
    this.enableInteractiveSelection = true,
    this.filled = true,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,

    ///Custom Parameter
    this.hintText,
    this.hintStyle,
    this.hintMaxLines,
    this.hintTextDirection,
    this.alignLabelWithHint,
    this.margin,
    super.key,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.height,
    this.appKey,
    this.elevation = 2,
    this.isDense = false,
    this.valueTransformer,
  });

  final GlobalKey<FormBuilderFieldState>? appKey;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration? decoration;

  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final BoxConstraints? prefixIconConstraints;
  final bool? autofocus;
  final bool? readOnly;
  final bool? showCursor;
  final String? obscuringCharacter;
  final bool? obscureText;
  final bool? autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool? enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int maxLines;

  final int? minLines;
  final bool? expands;
  final int? maxLength;
  final ValueChanged<String?>? onChanged;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final double? cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets? scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final ScrollController? scrollController;
  final String? restorationId;
  final MouseCursor? mouseCursor;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? border;

  final DragStartBehavior? dragStartBehavior;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final dynamic Function(String?)? valueTransformer;
  final EdgeInsets? margin;
  final String? description;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? title;
  final double elevation;
  final String? name;
  final bool filled;
  final Color? fillColor;

  ///Custom Parameter
  ///when pass [decoration] this will be ignore [hintText,hintStyle,hintMaxLines,hintTextDirection,alignLabelWithHint]
  final String? hintText;
  final TextStyle? hintStyle;
  final int? hintMaxLines;
  final TextDirection? hintTextDirection;
  final bool? alignLabelWithHint;
  final bool? isDense;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...{
            AppText.bodySmMedium(
              title!,
              color: context.colorScheme.primary,
            ),
            6.verticalSpace
          },
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Material(
                elevation: elevation,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                shadowColor: context.colorScheme.shadow.withOpacity(.2),
                child: SizedBox(
                  height: minLines != null ? height : 48.h,
                ),
              ),
              FormBuilderTextField(
                key: appKey,
                name: name ?? label ?? '',
                controller: controller,
                initialValue: initialValue,
                focusNode: focusNode,
                decoration: decoration ??
                    InputDecoration(
                      isDense: true,
                      label: label != null ? AppText(label!) : null,
                      hintText: hintText,
                      hintStyle: hintStyle ?? context.textTheme.subHeadMedium.copyWith(color: context.colorScheme.systemGray.shade200),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintMaxLines: hintMaxLines,
                      hintTextDirection: hintTextDirection,
                      contentPadding: REdgeInsetsDirectional.only(start: 16, top: 16, bottom: 10),
                      fillColor: fillColor ?? context.colorScheme.onPrimary,
                      focusColor: context.colorScheme.surface,
                      alignLabelWithHint: alignLabelWithHint,
                      suffixIcon: suffixIcon,
                      suffixIconConstraints: BoxConstraints(maxHeight: 40.h, minHeight: 10.h, minWidth: 40.w),
                      constraints: BoxConstraints(minHeight: 48.h),
                      prefixIconConstraints: BoxConstraints(maxHeight: 40.h, minHeight: 10.h, minWidth: 40.w),
                      prefixIcon: prefixIcon,
                      filled: filled,
                      border: border ??
                          OutlineInputBorder(
                            borderSide: BorderSide(color: context.colorScheme.outline),
                            borderRadius: BorderRadius.circular(8),
                          ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: context.colorScheme.outline),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: enabledBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(color: context.colorScheme.outline),
                            borderRadius: BorderRadius.circular(8),
                          ),
                      focusedBorder: focusedBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(color: context.colorScheme.primary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                      errorBorder: errorBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(color: context.colorScheme.error),
                            borderRadius: BorderRadius.circular(8),
                          ),
                    ).applyDefaults(
                      context.theme.inputDecorationTheme.copyWith(alignLabelWithHint: alignLabelWithHint),
                    ),
                valueTransformer: valueTransformer,
                keyboardType: keyboardType,
                textCapitalization: textCapitalization ?? TextCapitalization.none,
                textInputAction: textInputAction,
                style: style,
                strutStyle: strutStyle,
                textDirection: textDirection,
                textAlign: textAlign ?? TextAlign.start,
                textAlignVertical: textAlignVertical,
                autofocus: autofocus ?? false,
                readOnly: readOnly ?? false,
                showCursor: showCursor,
                obscuringCharacter: obscuringCharacter ?? '•',
                obscureText: obscureText ?? false,
                autocorrect: autocorrect ?? true,
                smartDashesType: smartDashesType,
                smartQuotesType: smartQuotesType,
                enableSuggestions: enableSuggestions ?? true,
                maxLengthEnforcement: maxLengthEnforcement,
                maxLines: maxLines,
                minLines: minLines,
                expands: expands ?? false,
                maxLength: maxLength,
                onChanged: onChanged,
                onTap: onTap,
                onTapOutside: onTapOutside,
                onEditingComplete: onEditingComplete,
                onSaved: onSaved,
                validator: validator,
                inputFormatters: inputFormatters,
                enabled: enabled,
                cursorWidth: cursorWidth ?? 2.0,
                cursorHeight: cursorHeight,
                cursorRadius: cursorRadius,
                cursorColor: cursorColor,
                keyboardAppearance: keyboardAppearance,
                scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
                enableInteractiveSelection: enableInteractiveSelection,
                buildCounter: buildCounter,
                scrollPhysics: scrollPhysics,
                autofillHints: autofillHints,
                autovalidateMode: autovalidateMode,
                scrollController: scrollController,
                restorationId: restorationId,
                mouseCursor: mouseCursor,
                contextMenuBuilder: contextMenuBuilder,
                magnifierConfiguration: magnifierConfiguration,
                dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
                contentInsertionConfiguration: contentInsertionConfiguration,
              ),
            ],
          ),
          if (description != null) ...{
            8.verticalSpace,
            AppText.bodyRegular(
              description!,
              color: const Color(0xff98A2B3),
              fontWeight: FontWeight.w400,
            ),
            16.verticalSpace
          }
        ],
      ),
    );
  }
}
