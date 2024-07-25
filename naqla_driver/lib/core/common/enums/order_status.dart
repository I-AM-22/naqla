import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';

import '../../../generated/l10n.dart';

enum SubOrderStatus {
  refused,
  waiting,
  ready,
  taken,
  onTheWay,
  delivered;

  String statusName({required BuildContext context}) {
    switch (this) {
      case SubOrderStatus.taken:
        return S.of(context).waiting_for_the_driver_to_arrive_and_pickUp_the_order;
      case SubOrderStatus.waiting:
        return S.of(context).your_order_is_under_scrutiny_by_the_admin_please_wait;
      case SubOrderStatus.ready:
        return S.of(context).waiting_for_drivers_to_be_hired;
      case SubOrderStatus.delivered:
        return S.of(context).delivered;
      case SubOrderStatus.onTheWay:
        return S.of(context).order_on_the_way;
      case SubOrderStatus.refused:
        return S.of(context).canceled;
    }
  }

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
      case SubOrderStatus.refused:
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
