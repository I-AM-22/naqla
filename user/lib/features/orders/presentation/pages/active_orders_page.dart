import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../core/common/enums/order_status.dart';
import '../../../app/presentation/widgets/states/app_common_state_builder.dart';
import '../../../home/data/model/order_model.dart';
import '../../../home/presentation/widget/order_card.dart';
import '../state/order_bloc.dart';

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
      onRefresh: () async {
        context.read<OrderBloc>().add(GetActiveOrdersEvent());
      },
      child: AppCommonStateBuilder<OrderBloc, List<OrderModel>>(
        stateName: OrderState.getActiveOrders,
        onSuccess: (data) {
          return ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: 10),
              child: OrderCard(
                orderModel: data[index],
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
