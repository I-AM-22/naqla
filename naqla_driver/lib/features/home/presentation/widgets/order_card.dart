import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../pages/order_details_page.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.subOrderModel});
  final SubOrderModel subOrderModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(OrderDetailsPage.name, extra: subOrderModel);
      },
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
        child: Container(
          padding: REdgeInsets.all(10),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(border: Border.all(color: context.colorScheme.primary), borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.bodySmMedium(
                '${S.of(context).weight}${subOrderModel.weight}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              8.verticalSpace,
              AppText.bodySmMedium('${S.of(context).cost}${formatter.format(subOrderModel.cost)} ${S.of(context).syp}'),
              8.verticalSpace,
              if ((subOrderModel.order?.porters ?? 0) > 0)
                AppText.bodySmMedium('${S.of(context).the_number_of_floors}: ${(subOrderModel.order?.porters ?? 1) - 1}'),
              if (subOrderModel.photos.isNotEmpty) ...{
                10.verticalSpace,
                Stack(
                  children: [
                    Container(
                        height: 150.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: context.colorScheme.outline)),
                        child: BlurHash(imageFit: BoxFit.contain, hash: subOrderModel.photos[0].blurHash, image: subOrderModel.photos[0].mobileUrl)),
                    if (subOrderModel.photos.length > 1)
                      Container(
                        color: context.colorScheme.primary.withOpacity(.5),
                        child: SizedBox(
                          height: 150.w,
                          child: Center(
                              child: AppText.titleMedium(
                            '+${subOrderModel.photos.length - 1}',
                            color: Colors.white,
                          )),
                        ),
                      )
                  ],
                )
              },
            ],
          ),
        ),
      ),
    );
  }
}
