import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';

class AppDropDown<T> extends StatefulWidget {
  final String? title;
  final String? name;
  final bool enabled;
  final bool isLoading;
  final bool isFailure;
  final T? initialValue;
  final String? hintText;
  final String? Function(Object?)? validator;
  final List<DropdownMenuItem<T>>? items;
  final VoidCallback? onRetry;
  final void Function(T?)? onChanged;
  final EdgeInsetsGeometry? margin;
  final double elevation;
  final bool isExpanded;
  final double? height;
  final Widget? child;
  final ButtonStyleData? buttonStyleData;
  final BoxBorder? border;
  const AppDropDown({
    super.key,
    this.isExpanded = true,
    this.title,
    required this.items,
    this.onRetry,
    this.enabled = true,
    this.isLoading = false,
    this.isFailure = false,
    this.elevation = 2,
    this.validator,
    this.name,
    this.initialValue,
    this.hintText,
    this.onChanged,
    this.margin,
    this.height,
    this.child,
    this.buttonStyleData,
    this.border,
  });

  @override
  State<AppDropDown<T>> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>> {
  T? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) AppText.bodyRegular(widget.title!),
          if (widget.title != null) 6.verticalSpace,
          SizedBox(
            height: widget.height ?? 48.h,
            child: Material(
              elevation: widget.elevation,
              borderRadius: BorderRadius.circular(8),
              shadowColor: context.colorScheme.shadow.withOpacity(.2),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<T>(
                  isExpanded: widget.isExpanded,
                  items: widget.isLoading || widget.isFailure ? [] : widget.items!,
                  iconStyleData: IconStyleData(
                    icon: widget.child ??
                        Padding(
                          padding: REdgeInsetsDirectional.only(end: 10),
                          child: AppImage.asset('Assets.icons.arrow.downArrow.path'),
                        ),
                  ),
                  onChanged: (value) => setState(() {
                    _selectedValue = value;
                    if (widget.onChanged != null) {
                      widget.onChanged!(value);
                    }
                  }),
                  value: _selectedValue,
                  buttonStyleData: widget.buttonStyleData ??
                      ButtonStyleData(
                        padding: REdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.colorScheme.surface,
                          border: widget.border ?? Border.all(color: context.colorScheme.outline, width: 1),
                        ),
                      ),
                  style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w100),
                  dropdownStyleData: DropdownStyleData(
                    offset: const Offset(0, 0),
                    elevation: 1,
                    maxHeight: 300.h,
                    padding: REdgeInsets.only(top: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
