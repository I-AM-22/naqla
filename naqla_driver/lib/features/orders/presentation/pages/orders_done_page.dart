import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla_driver/features/orders/presentation/pages/sub_order_details_page.dart';
import 'package:naqla_driver/features/orders/presentation/state/order_bloc.dart';

import '../../../home/data/model/sub_order_model.dart';
import '../widgets/sub_order_card.dart';

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
    return RefreshIndicator(
      onRefresh: () async => context.read<OrderBloc>().add(GetOrdersDoneEvent()),
      child: AppCommonStateBuilder<OrderBloc, List<SubOrderModel>>(
        stateName: OrderState.ordersDone,
        onSuccess: (data) => ListView.builder(
            itemBuilder: (context, index) => InkWell(
                onTap: () => context.pushNamed(SubOrderDetailsPage.name, extra: data[index].id), child: SubOrderCard(subOrderModel: data[index])),
            itemCount: data.length),
      ),
    );
  }
}
