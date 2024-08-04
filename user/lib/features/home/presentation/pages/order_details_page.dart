import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/domain/use_case/accept_order_use_case.dart';
import 'package:naqla/features/home/presentation/pages/payment_page.dart';

import '../../../../core/util/core_helper_functions.dart';
import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/animated_dialog.dart';
import '../bloc/home_bloc.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.orderModel});
  final OrderModel orderModel;

  static String path = "OrderDetailsPage";

  static String name = "OrderDetailsPage";

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeBloc>(),
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).order_details),
          ),
          bottomNavigationBar: Padding(
            padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: 10),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Row(
                  children: [
                    if (!state.getState(HomeState.cancelOrder).isLoading)
                      Expanded(
                        child: AppButton.dark(
                          isLoading: state.getState(HomeState.acceptOrder).isLoading,
                          title: S.of(context).confirm_order,
                          onPressed: () {
                            context.pushNamed(AddCardPageMobile.name,
                                extra: AcceptOrderParam(
                                    id: orderModel.id, cost: orderModel.paymentModel?.cost ?? 0, userId: orderModel.paymentModel?.id ?? ''));
                          },
                        ),
                      ),
                    5.horizontalSpace,
                    if (!state.getState(HomeState.acceptOrder).isLoading)
                      Expanded(
                        child: AppButton.dark(
                          isLoading: state.getState(HomeState.cancelOrder).isLoading,
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.resolveWith(
                            (states) => context.colorScheme.error,
                          )),
                          title: S.of(context).cancel_order,
                          onPressed: () {
                            AnimatedDialog.show(context,
                                child: Padding(
                                  padding: REdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppText.titleSmall(S.of(context).cancel_order),
                                      4.verticalSpace,
                                      AppText.bodyMedium(S.of(context).are_you_sure_you_want_to_cancel_the_order),
                                      16.verticalSpace,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: AppButton.dark(
                                                style: ButtonStyle(
                                                    backgroundColor: WidgetStateProperty.resolveWith(
                                                  (states) => context.colorScheme.error,
                                                )),
                                                buttonSize: ButtonSize.medium,
                                                child: AppText.bodySmall(
                                                  S.of(context).cancel_order,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () async {
                                                  context.read<HomeBloc>().add(CancelOrderEvent(
                                                      param: AcceptOrderParam(id: orderModel.id, cost: 0, userId: ''),
                                                      onSuccess: () {
                                                        context.pop();
                                                      }));
                                                  context.pop();
                                                }),
                                          ),
                                          16.horizontalSpace,
                                          Expanded(
                                            child: AppButton.gray(
                                              buttonSize: ButtonSize.medium,
                                              child: AppText.bodySmall(S.of(context).no),
                                              onPressed: () {
                                                context.pop(S.of(context).no);
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: UIConstants.screenPadding30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: REdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.outline,
                        offset: const Offset(0, 1),
                        blurRadius: 3,
                      )
                    ],
                    color: context.colorScheme.surface,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.subHeadMedium('${S.of(context).order_date} ${CoreHelperFunctions.fromDateTimeToString(orderModel.desiredDate)}'),
                      10.verticalSpace,
                      AppText.subHeadMedium('${S.of(context).order_status} ${orderModel.status.statusName(context: context)}'),
                      10.verticalSpace,
                      AppText.subHeadMedium('${S.of(context).cost} ${formatter.format(orderModel.paymentModel?.cost)} ${S.of(context).syp}'),
                    ],
                  ),
                ),
                16.verticalSpace,
                AppText.subHeadMedium(S.of(context).the_order_was_divided_into_orders(orderModel.subOrders?.length ?? 0)),
                16.verticalSpace,
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: context.colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: context.colorScheme.outline),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RichText(
                                      text: TextSpan(style: context.textTheme.bodyMedium, children: [
                                    TextSpan(text: '\t${S.of(context).the_weight}: ${orderModel.subOrders?[index].weight}\n\n'),
                                    TextSpan(
                                        text: '\t${S.of(context).cost}: ${formatter.format(orderModel.subOrders?[index].cost)} ${S.of(context).syp}'),
                                  ])),
                                ),
                              ),
                              if (orderModel.subOrders?[index].photos.isNotEmpty ?? false)
                                Expanded(
                                    child: SizedBox(
                                        height: 200.h,
                                        child: AppImage.network(fit: BoxFit.cover, orderModel.subOrders?[index].photos[0].mobileUrl ?? '')))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 10.verticalSpace,
                      itemCount: orderModel.subOrders?.length ?? 0),
                )
              ],
            ),
          )),
    );
  }
}
