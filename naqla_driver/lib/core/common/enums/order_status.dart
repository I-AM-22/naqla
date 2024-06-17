import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';

import '../../../generated/l10n.dart';

enum SubOrderStatus {
  waiting,
  ready,
  taken,
  onTheWay,
  delivered;

  Widget displayStatus(BuildContext context) {
    switch (this) {
      case SubOrderStatus.waiting:
        return Container(
          padding: REdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: context.colorScheme.waiting,
          ),
          child: Center(child: AppText.subHeadMedium('${S.of(context).order_status}: ${S.of(context).waiting_for_customer_confirmation}')),
        );
      case SubOrderStatus.taken:
        return Container(
          padding: REdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: context.colorScheme.waiting,
          ),
          child: Center(child: AppText.subHeadMedium('${S.of(context).order_status}: ${S.of(context).the_driver_agreed_to_the_request}')),
        );
      case SubOrderStatus.ready:
        return Container(
          padding: REdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: context.colorScheme.ready,
          ),
          child: Center(child: AppText.subHeadMedium('${S.of(context).order_status}: ${S.of(context).the_customer_has_confirmed_the_order}')),
        );
      case SubOrderStatus.onTheWay:
        return Container(
          padding: REdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: context.colorScheme.success.shade600,
          ),
          child: Center(child: AppText.subHeadMedium('${S.of(context).order_status}: ${S.of(context).order_on_the_way}')),
        );
      case SubOrderStatus.delivered:
        return Container(
          padding: REdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: context.colorScheme.success.shade600,
          ),
          child: Center(child: AppText.subHeadMedium('${S.of(context).order_status}: ${S.of(context).delivered}')),
        );
    }
  }
}
