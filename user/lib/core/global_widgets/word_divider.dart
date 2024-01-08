import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/core/core.dart';

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
