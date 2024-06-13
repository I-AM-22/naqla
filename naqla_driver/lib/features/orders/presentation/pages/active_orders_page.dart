import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/orders/presentation/state/order_bloc.dart';

import '../../../app/presentation/widgets/states/app_common_state_builder.dart';
import '../../../home/data/model/sub_order_model.dart';
import '../../../home/presentation/widgets/order_card.dart';
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
      onSuccess: (data) => ListView.builder(itemBuilder: (context, index) => AppText(data[index].status.name), itemCount: data.length),
    );
  }
}
