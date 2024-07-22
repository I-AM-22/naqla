import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/usecases/get_sub_orders_use_case.dart';
import 'package:naqla/features/orders/presentation/pages/sub_order_details_page.dart';
import 'package:naqla/features/orders/presentation/state/order_bloc.dart';

import '../../../../core/global_widgets/app_text.dart';
import '../../../../generated/l10n.dart';
import '../widgets/sub_order_card.dart';

class SubOrderParam {
  final String orderId;
  final bool isWaiting;

  SubOrderParam({required this.orderId, required this.isWaiting});
}

class SubOrdersPage extends StatefulWidget {
  const SubOrdersPage({super.key, required this.param});
  final SubOrderParam param;

  static String name = "SubOrdersPage";

  static String path = "SubOrdersPage";

  @override
  State<SubOrdersPage> createState() => _SubOrdersPageState();
}

class _SubOrdersPageState extends State<SubOrdersPage> {
  final OrderBloc bloc = getIt<OrderBloc>();
  @override
  void initState() {
    bloc.add(GetSubOrdersEvent(param: GetSubOrdersParam(orderId: widget.param.orderId)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(title: S.of(context).order_details),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            bloc.add(GetSubOrdersEvent(param: GetSubOrdersParam(orderId: widget.param.orderId)));
          },
          child: AppCommonStateBuilder<OrderBloc, List<SubOrderModel>>(
            stateName: OrderState.getSubOrders,
            onEmpty: Padding(
              padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20),
              child: Center(
                child: AppText.bodyRegular(widget.param.isWaiting
                    ? S.of(context).your_order_is_under_scrutiny_by_the_admin_please_wait
                    : S.of(context).your_order_was_rejected_by_the_admin),
              ),
            ),
            onSuccess: (data) {
              return Padding(
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: 10),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => context.pushNamed(SubOrderDetailsPage.name, extra: data[index].id),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: SubOrderCard(
                        orderModel: data[index],
                        index: index,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
