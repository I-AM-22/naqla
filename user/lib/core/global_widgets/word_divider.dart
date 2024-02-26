import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/config/themes/my_color_scheme.dart';
import 'package:naqla/core/util/extensions.dart';

import 'app_text.dart';

class WordDivider extends StatelessWidget {
  final String title;
  const WordDivider({super.key, this.title = 'OR'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.colorScheme.systemGray[300])),
        8.horizontalSpace,
        AppText.bodyMedium(title,
            fontWeight: FontWeight.w500,
            color: context.colorScheme.systemGray[300]),
        8.horizontalSpace,
        Expanded(child: Divider(color: context.colorScheme.systemGray[300])),
      ],
    );
  }
}
