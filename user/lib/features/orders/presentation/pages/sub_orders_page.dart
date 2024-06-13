import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/usecases/get_sub_orders_use_case.dart';
import 'package:naqla/features/orders/presentation/state/order_bloc.dart';

class SubOrdersPage extends StatefulWidget {
  const SubOrdersPage({super.key, required this.orderId});
  final String orderId;

  @override
  State<SubOrdersPage> createState() => _SubOrdersPageState();
}

class _SubOrdersPageState extends State<SubOrdersPage> {
  final OrderBloc bloc = getIt<OrderBloc>();
  @override
  void initState() {
    bloc.add(GetSubOrdersEvent(param: GetSubOrdersParam(orderId: widget.orderId)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppCommonStateBuilder<OrderBloc, List<SubOrderModel>>(
        stateName: OrderState.getSubOrders,
        onSuccess: (data) {
          return AppText('text');
        },
      ),
    );
  }
}
