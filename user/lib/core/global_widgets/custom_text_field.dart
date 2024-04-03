import 'package:flutter/material.dart';
import 'package:naqla/core/global_widgets/app_text.dart';

class CustomFormField<T> extends FormField<T> {
  CustomFormField(
      {super.key,
      EdgeInsetsGeometry? padding,
      super.onSaved,
      super.validator,
      super.initialValue,
      required Widget Function(FormFieldState<T>) child,
      super.autovalidateMode})
      : super(
            builder: (FormFieldState<T> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  child(state),
                  state.hasError
                      ? Padding(
                          padding: padding ?? EdgeInsets.zero,
                          child: AppText.bodySmall(
                            state.errorText ?? "some thing happened",
                            color: Colors.red,
                          ))
                      : Container()
                ],
              );
            });
}
