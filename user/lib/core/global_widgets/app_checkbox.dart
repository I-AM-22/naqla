import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/util/extensions.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    this.isSelected = false,
    this.onChanged,
    this.height,
    this.width,
  });

  final bool isSelected;
  final ValueChanged<bool>? onChanged;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: () {
          onChanged?.call(!isSelected);
        },
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 20.r,
            width: 20.r,
            decoration: BoxDecoration(
              border: buildBorder(),
              borderRadius: BorderRadius.circular(6.r),
              color: backgroundColor(context),
              boxShadow: isSelected && !isDisabled
                  ? [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 0,
                        offset: const Offset(0, 1),
                        color: _shadowCard1(0.05),
                      )
                    ]
                  : null,
            ),
            child: Center(
                child: Icon(
              Icons.check,
              color: iconColor(context),
              size: 16.r,
            )),
          ),
        ),
      ),
    );
  }

  Color iconColor(BuildContext context) {
    if (isSelected) {
      if (isDisabled) {
        return const Color(0xffD0D5DD);
      } else {
        return const Color(0xffD0D5DD);
      }
    }
    return isSelected ? context.colorScheme.primary : Colors.transparent;
  }

  Border? buildBorder() {
    if (isSelected) {
      return null;
    }
    return Border.all(
      color: const Color(0xffEAECF0),
      width: 1.25.r,
    );
  }

  Color backgroundColor(BuildContext context) {
    if (isDisabled) {
      return isSelected ? const Color(0xffEAECF0) : const Color(0xffF2F4F7);
    }
    return isSelected ? context.colorScheme.primary : context.colorScheme.surface;
  }

  bool get isDisabled => onChanged == null;
}

Color _shadowCard1(double opacity) {
  return Color.fromRGBO(16, 24, 40, opacity);
}
