import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/chat/data/model/message_model.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../core/util/core_helper_functions.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.item});
  final MessageModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
      child: Column(
        crossAxisAlignment: !item.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          Container(
            padding: REdgeInsets.all(7),
            decoration: BoxDecoration(
                color: !item.isUser ? context.colorScheme.systemGray.shade100 : context.colorScheme.primary50,
                borderRadius: BorderRadius.only(
                    topRight: !item.isUser ? const Radius.circular(8) : Radius.zero,
                    topLeft: item.isUser ? const Radius.circular(8) : Radius.zero,
                    bottomLeft: const Radius.circular(8),
                    bottomRight: const Radius.circular(8)),
                border: !item.isUser ? null : Border.all(color: context.colorScheme.primary)),
            child: AppText.bodyRegular(
              item.content,
              style: TextStyle(fontSize: 14.sp),
              color: item.isUser ? context.colorScheme.tertiary : context.colorScheme.systemGray.shade700,
            ),
          ),
          AppText.bodyRegular(
            CoreHelperFunctions.fromMessageDateTimeToString(item.createdAt),
            style: TextStyle(fontSize: 12.sp),
            color: context.colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}
