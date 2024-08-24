import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core.dart';

class CustomFormBuilderField<T> extends FormBuilderFieldDecoration<T> {
  CustomFormBuilderField({
    super.key,
    EdgeInsetsGeometry? padding,
    required super.name,
    FormFieldSetter<T>? onSaved,
    super.validator,
    super.initialValue,
    required Widget Function(FormFieldState<T>) child,
  }) : super(
            builder: (state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    child(state),
                    8.verticalSpace,
                    state.hasError
                        ? Padding(
                            padding: padding ?? REdgeInsets.symmetric(horizontal: 16),
                            child: AppText.labelSmall(
                              state.errorText ?? "some thing happened",
                              color: state.context.colorScheme.error,
                            ))
                        : Container()
                  ],
                ));
}
