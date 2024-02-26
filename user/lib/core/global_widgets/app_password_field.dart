import 'package:flutter/material.dart';
import 'package:naqla/core/global_widgets/app_text_field.dart';

class AppPasswordField extends StatefulWidget {
  final String? name;
  final String? hintText;
  final String? initialValue;
  final String? Function(String?)? validator;
  const AppPasswordField(
      {super.key, this.name, this.hintText, this.initialValue, this.validator});

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      name: widget.name ?? 'password',
      hintText: widget.hintText ?? 'Password',
      obscureText: _obscureText,
      validator: widget.validator,
      initialValue: widget.initialValue,
      keyboardType: TextInputType.visiblePassword,
      suffixIcon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: IconButton(
          key: ValueKey<bool>(_obscureText),
          onPressed: () => setState(() => _obscureText = !_obscureText),
          icon: _obscureText
              ? Icon(Icons.visibility_outlined, color: Colors.grey[500])
              : Icon(Icons.visibility_off_outlined, color: Colors.grey[500]),
        ),
      ),
    );
  }
}
