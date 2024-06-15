import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqla_driver/core/common/enums/order_status.dart';
import 'package:naqla_driver/features/orders/presentation/state/order_bloc.dart';
import 'package:naqla_driver/features/orders/presentation/widgets/sub_order_card.dart';

import '../../../app/presentation/widgets/states/app_common_state_builder.dart';
import '../../data/model/sub_two_order_model.dart';

class ActiveOrdersPage extends StatefulWidget {
  const ActiveOrdersPage({super.key});

  @override
  State<ActiveOrdersPage> createState() => _ActiveOrdersPageState();
}

class _ActiveOrdersPageState extends State<ActiveOrdersPage> {
  @override
  void initState() {
    context.read<OrderBloc>().add(GetOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCommonStateBuilder<OrderBloc, List<Sub2OrderModel>>(
      stateName: OrderState.getOrders,
      onSuccess: (data) => ListView.builder(
          itemBuilder: (context, index) => SubOrderCard(
              subOrderModel: data
                  .where(
                    (element) => element.status != SubOrderStatus.delivered,
                  )
                  .elementAt(index)),
          itemCount: data
              .where(
                (element) => (element.status != SubOrderStatus.delivered),
              )
              .length),
    );
  }
}
