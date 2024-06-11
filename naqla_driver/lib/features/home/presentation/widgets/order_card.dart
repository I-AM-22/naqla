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
    return Padding(
      padding: REdgeInsets.symmetric(vertical: UIConstants.screenPadding20, horizontal: UIConstants.screenPadding16),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(border: Border.all(color: context.colorScheme.primary), borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodySmMedium('${S.of(context).weight}${subOrderModel.weight.toString()}'),
                  10.verticalSpace,
                  AppText.bodySmMedium('${S.of(context).cost}${subOrderModel.cost.toString()}'),
                  10.verticalSpace,
                  AppText.bodySmMedium('${S.of(context).porters}${subOrderModel.order.porters.toString()}'),
                  10.verticalSpace,
                  AppButton.dark(
                    buttonSize: ButtonSize.medium,
                    title: S.of(context).more_details,
                    textStyle: context.textTheme.bodySmall?.copyWith(color: Colors.white),
                    onPressed: () {
                      context.pushNamed(OrderDetailsPage.name, extra: subOrderModel);
                    },
                  ),
                ],
              ),
            ),
            if (subOrderModel.photos.isNotEmpty) ...{
              const Spacer(),
              Stack(
                children: [
                  SizedBox(
                      height: 150.h,
                      width: 150.w,
                      child: BlurHash(imageFit: BoxFit.cover, hash: subOrderModel.photos[0].blurHash, image: subOrderModel.photos[0].mobileUrl)),
                  if (subOrderModel.photos.length > 1)
                    Container(
                      color: context.colorScheme.primary.withOpacity(.5),
                      child: SizedBox(
                        width: 150.w,
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
            }
          ],
        ),
      ),
    );
  }
}
