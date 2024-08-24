import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/orders/presentation/widgets/photo_card_widget.dart';

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
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(border: Border.all(color: context.colorScheme.primary), borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: TextSpan(style: context.textTheme.subHeadRegular.copyWith(color: context.colorScheme.primary), children: [
                  TextSpan(text: '${S.of(context).weight}${subOrderModel.weight}\n'),
                  TextSpan(text: '${S.of(context).cost}${formatter.format(subOrderModel.cost)} ${S.of(context).syp}\n'),
                  if ((subOrderModel.order?.porters ?? 0) > 0)
                    TextSpan(text: '${S.of(context).the_number_of_floors}: ${(subOrderModel.order?.porters ?? 1) - 1}\n'),
                ])),
              ),
              if (subOrderModel.photos.isNotEmpty) ...{
                PhotoCardWidget(
                  photoPath: subOrderModel.photos[0].mobileUrl,
                  length: subOrderModel.photos.length,
                )
              },
            ],
          ),
        ),
      ),
    );
  }
}
