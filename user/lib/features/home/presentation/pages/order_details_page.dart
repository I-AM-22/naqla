import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
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

import '../../../../core/util/core_helper_functions.dart';
import '../../../../generated/l10n.dart';
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
            child: BlocSelector<HomeBloc, HomeState, CommonState>(
              selector: (state) => state.getState(HomeState.acceptOrder),
              builder: (context, state) {
                return AppButton.dark(
                  isLoading: state.isLoading,
                  title: S.of(context).confirm_order,
                  onPressed: () {
                    context.read<HomeBloc>().add(AcceptOrderEvent(
                        param: AcceptOrderParam(id: orderModel.id),
                        onSuccess: () {
                          context.pop();
                        }));
                  },
                );
              },
            ),
          ),
          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: UIConstants.screenPadding30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.bodySmMedium('${S.of(context).order_date} ${CoreHelperFunctions.fromDateTimeToString(orderModel.desiredDate)}'),
                10.verticalSpace,
                AppText.bodySmMedium('${S.of(context).order_status} ${orderModel.status.name}'),
                10.verticalSpace,
                AppText.bodySmMedium('${S.of(context).cost} ${orderModel.paymentModel?.cost} ${S.of(context).syp}'),
                16.verticalSpace,
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: context.colorScheme.outline),
                          ),
                          child: BlurHash(
                            hash: orderModel.photos[index].blurHash,
                            image: orderModel.photos[index].mobileUrl,
                            imageFit: BoxFit.contain,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 10.verticalSpace,
                      itemCount: orderModel.photos.length),
                )
              ],
            ),
          )),
    );
  }
}
