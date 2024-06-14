import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';

enum SubOrderStatus {
  waiting,
  ready,
  taken,
  onTheWay,
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
}
