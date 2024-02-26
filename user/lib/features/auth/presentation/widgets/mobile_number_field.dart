import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/global_widgets/app_image.dart';
import '../../../../core/global_widgets/app_text_field.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';

class AppMobileNumberField extends StatelessWidget {
  final String? description;
  final String? hintText;
  final String? title;
  final bool isPassword;
  const AppMobileNumberField(
      {super.key,
      this.description,
      this.hintText,
      this.title,
      this.isPassword = true});

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      description: description,
      hintText: hintText ?? '0934 567 890',
      prefixIcon: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: isPassword
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    12.horizontalSpace,
                    AppImage.asset(Assets.icons.flags.syria.path, size: 30),
                    5.horizontalSpace,
                  ],
                )
              : null,
          items: const [],
          onChanged: (value) {},
          buttonStyleData: ButtonStyleData(width: 60.w),
          iconStyleData: IconStyleData(
            icon: Padding(
              padding: REdgeInsets.only(
                left: isPassword ? 0 : 25,
              ),
              child: AppImage.asset(
                Assets.icons.arrow.downArrow.path,
                size: 15,
              ),
            ),
          ),
          dropdownStyleData: const DropdownStyleData(),
          menuItemStyleData: const MenuItemStyleData(),
        ),
      ),
    );
  }
}
