import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../orders/data/model/sub_order_model.dart';
import '../pages/messages_page.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.item});
  final SubOrderModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(MessagesPage.name,
          extra: MessageParam(subOrderId: item.id, driverName: '${item.carModel?.driver?.firstName} ${item.carModel?.driver?.lastName}')),
      child: Container(
        // margin: REdgeInsets.only(bottom: 16),
        // alignment: AlignmentDirectional.centerStart,
        // padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: 8),
        // decoration: BoxDecoration(
        //   boxShadow: [BoxShadow(color: context.colorScheme.black.withOpacity(.24), offset: const Offset(0, 2), blurRadius: 5)],
        //   border: Border.all(color: context.colorScheme.primary),
        //   borderRadius: BorderRadius.circular(8),
        //   color: context.colorScheme.onPrimary,
        // ),
        child: Row(
          children: [
            if (item.photos.isNotEmpty)
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: context.colorScheme.black.withOpacity(.24), offset: const Offset(0, 0), blurRadius: 1)],
                  shape: BoxShape.circle,
                ),
                child: AppImage.network(
                  item.photos[0].mobileUrl,
                  size: 50.r,
                ),
              ),
            8.horizontalSpace,
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: RichText(
                      text: TextSpan(style: context.textTheme.titleSmall, children: [
                        TextSpan(text: '${item.carModel?.driver?.firstName} ${item.carModel?.driver?.lastName}\n'),
                        TextSpan(
                            style: context.textTheme.bodySmall,
                            text:
                                '${item.order?.locationStart?.region} [${item.order?.locationStart?.street}] --> ${item.order?.locationEnd?.region} [${item.order?.locationEnd?.street}]'),
                      ]),
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
