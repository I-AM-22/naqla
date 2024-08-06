import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';

enum OrderStatus {
  waiting,
  ready,
  accepted,
  refused,
  canceled,
  onTheWay,
  delivered;

  String statusName({required BuildContext context}) {
    switch (this) {
      case OrderStatus.waiting:
        return S.of(context).your_order_is_under_scrutiny_by_the_admin_please_wait;
      case OrderStatus.ready:
        return S.of(context).confirm_the_order;
      case OrderStatus.delivered:
        return S.of(context).delivered;
      case OrderStatus.onTheWay:
        return S.of(context).order_on_the_way;
      case OrderStatus.accepted:
        return S.of(context).waiting_for_the_driver_to_arrive_and_pickUp_the_order;
      case OrderStatus.canceled:
        return S.of(context).your_order_was_rejected_by_the_admin;
      case OrderStatus.refused:
        return S.of(context).canceled;
    }
  }
}
