import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';

import '../../../generated/l10n.dart';

enum SubOrderStatus {
  waiting,
  ready,
  taken,
  onTheWay,
  refused,
  delivered;

  String buttonTitle(BuildContext context) {
    switch (this) {
      case SubOrderStatus.taken:
        return S.of(context).driver_arrived;
      case SubOrderStatus.onTheWay:
        return S.of(context).set_order_delivered;
      default:
        return S.of(context).set_order_picked_up;
    }
  }

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

  Widget displayStatus(BuildContext context, {DateTime? arrivedAt}) {
    switch (this) {
      case SubOrderStatus.taken:
        return Container(
          padding: REdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colorScheme.waiting,
          ),
          child: Center(
              child: AppText.subHeadMedium(
                  arrivedAt == null ? S.of(context).waiting_for_the_driver_to_arrive : S.of(context).waiting_for_the_order_to_be_pickUp)),
        );
      case SubOrderStatus.ready:
        return Container(
          padding: REdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colorScheme.ready,
          ),
          child: Center(child: AppText.subHeadMedium(S.of(context).waiting_for_drivers_to_be_hired)),
        );
      case SubOrderStatus.onTheWay:
        return Container(
          padding: REdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colorScheme.success.shade600,
          ),
          child: Center(child: AppText.subHeadMedium(S.of(context).order_on_the_way)),
        );
      case SubOrderStatus.delivered:
        return Container(
          padding: REdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colorScheme.delivered,
          ),
          child: Center(child: AppText.subHeadMedium(S.of(context).delivered)),
        );
      case SubOrderStatus.waiting:
        return Container(
          padding: REdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colorScheme.waiting,
          ),
          child: Center(child: AppText.subHeadMedium(S.of(context).waiting_for_customer_confirmation)),
        );
      case SubOrderStatus.refused:
        return Container(
          padding: REdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colorScheme.warning,
          ),
          child: Center(child: AppText.subHeadMedium(S.of(context).the_order_has_been_canceled)),
        );
    }
  }
}
