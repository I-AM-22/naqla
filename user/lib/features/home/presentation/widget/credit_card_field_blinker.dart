import 'package:flutter/material.dart';

import '../../../../core/common/enums/credit_card_field.dart';

class CreditCardFieldBlinker extends StatelessWidget {
  final ValueNotifier<CreditCardField?> blinkField;
  final AnimationController animationController;
  final Widget widget;
  final CreditCardField field;
  const CreditCardFieldBlinker({
    super.key,
    required this.animationController,
    required this.blinkField,
    required this.field,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: blinkField,
      builder: (context, value, child) {
        if (value == field) {
          return AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => Opacity(opacity: animationController.value, child: widget),
          );
        }
        return widget;
      },
    );
  }
}
