import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/config/themes/my_color_scheme.dart';
import 'package:naqla/core/util/extensions/build_context.dart';

import 'app_text.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    this.controller,
    this.initialValue,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
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
    this.maxLines = 1,
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
    this.enabled = true,
    this.isPasswordField = false,
    this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding,
    this.enableInteractiveSelection = true,
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
    this.name,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.border,
    this.filled = true,
    this.fillColor,

    ///Custom Parameter
    this.hintText,
    this.hintStyle,
    this.hintMaxLines,
    this.hintTextDirection,
    this.alignLabelWithHint,
    this.elevation = 2,
    this.margin,
    super.key,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.height,
    this.valueTransformer,
  });

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
  final dynamic Function(String?)? valueTransformer;
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
  final EdgeInsets? margin;
  final String? description;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double elevation;
  final String? name;
  final bool filled;
  final Color? fillColor;
  final bool isPasswordField;

  ///Custom Parameter
  ///when pass [decoration] this will be ignore [hintText,hintStyle,hintMaxLines,hintTextDirection,alignLabelWithHint]
  final String? hintText;
  final TextStyle? hintStyle;
  final int? hintMaxLines;
  final TextDirection? hintTextDirection;
  final bool? alignLabelWithHint;
  final double? height;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late final ValueNotifier<bool> obscureTextValue;
  @override
  void initState() {
    obscureTextValue = ValueNotifier(widget.isPasswordField);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
            valueListenable: obscureTextValue,
            builder: (context, obscureValue, _) => Material(
              elevation: widget.elevation,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadowColor: context.colorScheme.shadow.withOpacity(.2),
              child: SizedBox(
                height: widget.minLines != null ? widget.height : 48.h,
                child: FormBuilderTextField(
                  name: widget.name ?? widget.label ?? '',
                  controller: widget.controller,
                  initialValue: widget.initialValue,
                  focusNode: widget.focusNode,
                  decoration: widget.decoration ??
                      InputDecoration(
                        label: widget.label != null
                            ? AppText(widget.label!)
                            : null,
                        hintText: widget.hintText,
                        hintStyle: widget.hintStyle ??
                            context.textTheme.bodyMedium
                                ?.copyWith(color: const Color(0xff98A2B3)),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        hintMaxLines: widget.hintMaxLines,
                        hintTextDirection: widget.hintTextDirection,
                        contentPadding: REdgeInsetsDirectional.only(
                            start: 16, top: 16, bottom: 10),
                        fillColor:
                            widget.fillColor ?? context.colorScheme.onPrimary,
                        focusColor: context.colorScheme.surface,
                        alignLabelWithHint: widget.alignLabelWithHint,
                        suffixIcon: widget.isPasswordField
                            ? eyeIcon(obscureValue, context)
                            : widget.suffixIcon,
                        prefixIconConstraints: BoxConstraints(
                            maxHeight: 40.h, minHeight: 10.h, minWidth: 40.w),
                        prefixIcon: widget.prefixIcon,
                        filled: widget.filled,
                        border: widget.border ??
                            OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      context.colorScheme.systemGray.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                        enabledBorder: widget.enabledBorder ??
                            OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      context.colorScheme.systemGray.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                        focusedBorder: widget.focusedBorder ??
                            OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: context.colorScheme.primary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                      ).applyDefaults(
                        context.theme.inputDecorationTheme.copyWith(
                            alignLabelWithHint: widget.alignLabelWithHint),
                      ),
                  keyboardType: widget.keyboardType,
                  valueTransformer: widget.valueTransformer,
                  textCapitalization:
                      widget.textCapitalization ?? TextCapitalization.none,
                  textInputAction: widget.textInputAction,
                  style: widget.style,
                  strutStyle: widget.strutStyle,
                  textDirection: widget.textDirection,
                  textAlign: widget.textAlign ?? TextAlign.start,
                  textAlignVertical: widget.textAlignVertical,
                  autofocus: widget.autofocus ?? false,
                  readOnly: widget.readOnly ?? false,
                  showCursor: widget.showCursor,
                  obscuringCharacter: widget.obscuringCharacter ?? '•',
                  obscureText: obscureValue,
                  autocorrect: widget.autocorrect ?? true,
                  smartDashesType: widget.smartDashesType,
                  smartQuotesType: widget.smartQuotesType,
                  enableSuggestions: widget.enableSuggestions ?? true,
                  maxLengthEnforcement: widget.maxLengthEnforcement,
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  expands: widget.expands ?? false,
                  maxLength: widget.maxLength,
                  onChanged: widget.onChanged,
                  onTap: widget.onTap,
                  onTapOutside: widget.onTapOutside,
                  onEditingComplete: widget.onEditingComplete,
                  onSaved: widget.onSaved,
                  validator: widget.validator,
                  inputFormatters: widget.inputFormatters,
                  enabled: widget.enabled,
                  cursorWidth: widget.cursorWidth ?? 2.0,
                  cursorHeight: widget.cursorHeight,
                  cursorRadius: widget.cursorRadius,
                  cursorColor: widget.cursorColor,
                  keyboardAppearance: widget.keyboardAppearance,
                  scrollPadding:
                      widget.scrollPadding ?? const EdgeInsets.all(20.0),
                  enableInteractiveSelection: widget.enableInteractiveSelection,
                  buildCounter: widget.buildCounter,
                  scrollPhysics: widget.scrollPhysics,
                  autofillHints: widget.autofillHints,
                  autovalidateMode: widget.autovalidateMode,
                  scrollController: widget.scrollController,
                  restorationId: widget.restorationId,
                  mouseCursor: widget.mouseCursor,
                  contextMenuBuilder: widget.contextMenuBuilder,
                  magnifierConfiguration: widget.magnifierConfiguration,
                  dragStartBehavior:
                      widget.dragStartBehavior ?? DragStartBehavior.start,
                  contentInsertionConfiguration:
                      widget.contentInsertionConfiguration,
                ),
              ),
            ),
          ),
          if (widget.description != null) ...{
            AppText.subHeadMedium(
              widget.description!,
              color: const Color(0xff98A2B3),
              fontWeight: FontWeight.w400,
            ),
            16.verticalSpace
          }
        ],
      ),
    );
  }

  Widget eyeIcon(bool obscure, BuildContext context) {
    return IconButton(
      onPressed: () => obscureTextValue.value = !obscure,
      icon: Icon(obscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
          color: context.colorScheme.primary),
    );
  }
}
