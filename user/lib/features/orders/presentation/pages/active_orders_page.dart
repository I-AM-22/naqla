import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../core/common/enums/order_status.dart';
import '../../../../core/global_widgets/app_image.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../app/presentation/widgets/states/app_common_state_builder.dart';
import '../../../home/data/model/order_model.dart';
import '../../../home/presentation/widget/order_card.dart';
import '../state/order_bloc.dart';

class ActiveOrdersPage extends StatelessWidget {
  const ActiveOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OrderBloc>().add(GetOrdersEvent());
      },
      child: AppCommonStateBuilder<OrderBloc, List<OrderModel>>(
        stateName: OrderState.getOrders,
        onSuccess: (data) {
          return data
                  .where(
                    (element) =>
                        (element.status != OrderStatus.delivered && element.status != OrderStatus.refused && element.status != OrderStatus.canceled),
                  )
                  .isEmpty
              ? ListView(
                  padding: REdgeInsets.symmetric(vertical: UIConstants.screenPadding30),
                  children: [
                    AppImage.asset(Assets.images.svg.noDataRafiki1.path),
                  ],
                )
              : ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: 10),
                    child: OrderCard(
                      orderModel: data
                          .where(
                            (element) => (element.status != OrderStatus.delivered &&
                                element.status != OrderStatus.refused &&
                                element.status != OrderStatus.canceled),
                          )
                          .elementAt(index),
                      showIndicator: false,
                    ),
                  ),
                  itemCount: data
                      .where(
                        (element) => (element.status != OrderStatus.delivered &&
                            element.status != OrderStatus.refused &&
                            element.status != OrderStatus.canceled),
                      )
                      .length,
                );
        },
      ),
    );
  }
}
