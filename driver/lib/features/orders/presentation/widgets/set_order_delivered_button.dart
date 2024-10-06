import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_loading_indicator.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/orders/domain/usecases/set_delivered_use_case.dart';
import 'package:naqla_driver/features/orders/presentation/state/order_bloc.dart';
import 'package:naqla_driver/generated/l10n.dart';

// ignore: must_be_immutable
class SetOrderDeliveredButton extends StatelessWidget {
  SetOrderDeliveredButton({super.key, required this.subOrderModel});
  final SubOrderModel subOrderModel;

  List<String> orderId = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        orderId.add(subOrderModel.id);
        context.read<OrderBloc>().add(SetDeliveredEvent(
              param: SetDeliveredParam(id: subOrderModel.id),
              onSuccess: () {
                orderId.remove(subOrderModel.id);
              },
              onFailure: () {
                orderId.remove(subOrderModel.id);
              },
            ));
      },
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
          border: Border.all(color: context.colorScheme.outline),
          color: context.colorScheme.primary,
        ),
        child: Center(
          child: BlocSelector<OrderBloc, OrderState, CommonState>(
            selector: (state) => state.getState(OrderState.setDelivered),
            builder: (context, state) {
              if (state.isLoading && orderId.contains(subOrderModel.id)) {
                return AppLoadingIndicator(
                  color: Colors.white,
                  size: 25.r,
                );
              } else {
                return AppText.subHeadMedium(
                  S.of(context).delivered,
                  color: Colors.white,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
