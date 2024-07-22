import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/common/enums/order_status.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/presentation/widget/order_card.dart';
import 'package:naqla/features/orders/presentation/state/order_bloc.dart';

class DoneOrdersPage extends StatefulWidget {
  const DoneOrdersPage({super.key});

  @override
  State<DoneOrdersPage> createState() => _DoneOrdersPageState();
}

class _DoneOrdersPageState extends State<DoneOrdersPage> {
  @override
  void initState() {
    context.read<OrderBloc>().add(GetDoneOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OrderBloc>().add(GetDoneOrdersEvent());
      },
      child: AppCommonStateBuilder<OrderBloc, List<OrderModel>>(
        stateName: OrderState.getDoneOrders,
        onSuccess: (data) {
          return ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: 10),
              child: OrderCard(
                orderModel: data.elementAt(index),
                showBorder: true,
                isWaiting: data.elementAt(index).status == OrderStatus.waiting,
              ),
            ),
            itemCount: data.length,
          );
        },
      ),
    );
  }
}
