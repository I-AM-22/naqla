import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/config/router/router.dart';
import 'package:user/core/core.dart';

import '../../../../core/util/responsive_padding.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../services/language_service.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  List<String> countriesFlags = [
    Assets.images.svg.english.path,
    Assets.images.svg.arabic.path,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: HWEdgeInsets.symmetric(vertical: 33),
      child: ListView.separated(
        padding: HWEdgeInsets.only(bottom: 30),
        itemBuilder: (_, index) => InkWell(
          onTap: () async {
            await context.setLocale(localMap.values.toList()[index]);
            if (context.mounted) {
              Navigator.pop(context);
              context.goNamed(GRouter.config.splashScreen);
            }
          },
          child: languageItem(
            countriesFlags[index],
            languageNameAndLanguageCode.keys.toList()[index],
          ),
        ),
        separatorBuilder: (_, index) => Divider(
          color: Theme.of(context).colorScheme.dividerColor,
          indent: 22.w,
          endIndent: 22.w,
          height: 22.h,
        ),
        itemCount: languageNameAndLanguageCode.keys.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }

  Widget languageItem(String countryIcon, String language) {
    return Row(
      children: [
        33.horizontalSpace,
        AppImage.asset(countryIcon),
        10.horizontalSpace,
        AppText.bodyMedium(
          language,
        )
      ],
    );
  }
}
