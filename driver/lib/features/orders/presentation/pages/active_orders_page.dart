import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/common/enums/order_status.dart';
import 'package:naqla_driver/features/orders/presentation/pages/sub_order_details_page.dart';
import 'package:naqla_driver/features/orders/presentation/state/order_bloc.dart';
import 'package:naqla_driver/features/orders/presentation/widgets/sub_order_card.dart';

import '../../../app/presentation/widgets/states/app_common_state_builder.dart';
import '../../../home/data/model/sub_order_model.dart';

class ActiveOrdersPage extends StatefulWidget {
  const ActiveOrdersPage({super.key});

  @override
  State<ActiveOrdersPage> createState() => _ActiveOrdersPageState();
}

class _ActiveOrdersPageState extends State<ActiveOrdersPage> {
  @override
  void initState() {
    context.read<OrderBloc>().add(GetActiveOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<OrderBloc>().add(GetActiveOrdersEvent()),
      child: AppCommonStateBuilder<OrderBloc, List<SubOrderModel>>(
        stateName: OrderState.getActiveOrders,
        onSuccess: (data) => ListView.builder(
            itemBuilder: (context, index) => InkWell(
                  onTap: () => context.pushNamed(SubOrderDetailsPage.name, extra: data[index].id),
                  child: SubOrderCard(subOrderModel: data.elementAt(index)),
                ),
            itemCount: data
                .where(
                  (element) => (element.status != SubOrderStatus.delivered),
                )
                .length),
      ),
    );
  }
}
