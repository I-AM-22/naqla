import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../app/presentation/pages/app.dart';

class CustomDropDownLanguage extends StatelessWidget {
  CustomDropDownLanguage({super.key});
  final _tooltipController = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return CustomDropDown(
      isExpanded: false,
      tooltipController: _tooltipController,
      followerAnchor: context.isArabic ? Alignment.topLeft : Alignment.topRight,
      hideBarrierColor: true,
      menuWidget: Container(
        // height: 150.h,
        width: 256.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorScheme.systemGray.shade200,
            width: 1.r,
          ),
          borderRadius: BorderRadius.circular(8.r),
          color: context.colorScheme.surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppMenuItem(
              isSelected: !context.isArabic,
              showCheck: true,
              onChanged: (select) {
                if (select) {
                  App.englishLanguage.value = true;
                }
              },
              showImage: false,
              textColor: !context.isArabic ? context.colorScheme.primary : context.colorScheme.systemGray.shade400,
              text: 'English',
              image: '',
              isLastItem: false,
              onTap: () {
                _tooltipController.toggle();
              },
            ),
            AppMenuItem(
              isSelected: context.isArabic,
              showCheck: true,
              showImage: false,
              onChanged: (select) {
                if (select) {
                  App.englishLanguage.value = false;
                  // HiveService.hive.put('language', 'ar');
                }
              },
              textColor: context.isArabic ? context.colorScheme.primary : context.colorScheme.systemGray.shade400,
              text: 'Arabic',
              image: '',
              isLastItem: true,
              onTap: () {
                _tooltipController.toggle();
              },
            ),
          ],
        ),
      ),
      child: AppImage.asset(
        Assets.icons.arrow.downArrow.path,
        size: 15,
        color: context.colorScheme.systemGray.shade400,
      ),
    );
  }

  bool getColorSelectLanguage(Locale locale, BuildContext context) => context.locale == locale;
}
