import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/core.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../home/data/model/sub_order_model.dart';
import '../pages/messages_page.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.item});
  final SubOrderModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(MessagesPage.name, extra: item.id),
      child: Container(
        margin: REdgeInsets.only(bottom: 16),
        alignment: AlignmentDirectional.centerStart,
        padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: 8),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: context.colorScheme.black.withOpacity(.24), offset: const Offset(0, 0), blurRadius: 1)],
          border: Border.all(color: context.colorScheme.primary),
          borderRadius: BorderRadius.circular(8),
          color: context.colorScheme.onPrimary,
        ),
        child: Row(
          children: [
            if (item.photos.isNotEmpty)
              CircleAvatar(
                radius: 25.r,
                backgroundImage: NetworkImage(item.photos[0].mobileUrl),
                backgroundColor: context.colorScheme.systemGray.shade200,
              ),
            8.horizontalSpace,
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AppText.subHeadMedium(
                      '${item.order?.locationStart.region} [${item.order?.locationStart.street}] --> ${item.order?.locationEnd.region} [${item.order?.locationEnd.street}]',
                    ),
                  ),
                  AppImage.asset(
                    context.isArabic ? Assets.icons.arrow.leftArrow.path : Assets.icons.arrow.rightArrow.path,
                    size: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
