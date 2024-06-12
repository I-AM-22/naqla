import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla_driver/features/orders/presentation/state/order_bloc.dart';

import '../../data/model/sub_two_order_model.dart';

class OrdersDonePage extends StatefulWidget {
  const OrdersDonePage({super.key});

  @override
  State<OrdersDonePage> createState() => _OrdersDonePageState();
}

class _OrdersDonePageState extends State<OrdersDonePage> {
  @override
  void initState() {
    context.read<OrderBloc>().add(GetOrdersDoneEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCommonStateBuilder<OrderBloc, List<Sub2OrderModel>>(
      stateName: OrderState.ordersDone,
      onSuccess: (data) => ListView.builder(itemBuilder: (context, index) => AppText(data[index].status.name), itemCount: data.length),
    );
  }
}
