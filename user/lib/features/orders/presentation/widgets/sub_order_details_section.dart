import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/util/core_helper_functions.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/generated/l10n.dart';

class SubOrderDetailsSection extends StatelessWidget {
  const SubOrderDetailsSection({super.key, required this.data});
  final SubOrderModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20),
      child: Container(
        padding: REdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.primary.withOpacity(.2),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: RichText(
          text: TextSpan(style: context.textTheme.subHeadMedium.copyWith(color: context.colorScheme.primary, height: 1.5), children: [
            if (data.note != null && data.rating != 0) ...{
              TextSpan(text: '${S.of(context).rating}: '),
              TextSpan(text: '⭐ ' * data.rating.toInt()),
              TextSpan(text: '\n${S.of(context).notes}: ${data.note}\n'),
            },
            TextSpan(text: '${S.of(context).cost} ${formatter.format(data.realCost)} ${S.of(context).syp}\n'),
            TextSpan(text: '${S.of(context).the_weight}: ${data.weight}\n'),
            if ((data.order?.porters ?? 0) > 0) TextSpan(text: '${S.of(context).the_number_of_floors}: ${(data.order?.porters ?? 1) - 1}\n'),
            TextSpan(text: '${S.of(context).order_date}: ${CoreHelperFunctions.fromOrderDateTimeToString(data.order!.desiredDate)}\n'),
            TextSpan(
                text: CoreHelperFunctions.formatOrderTime(context, data.status,
                    deliveredAt: data.deliveredAt,
                    acceptedAt: data.acceptedAt,
                    driverAssignedAt: data.driverAssignedAt,
                    pickedUpAt: data.pickedUpAt)),
          ]),
        ),
      ),
    );
  }
}
