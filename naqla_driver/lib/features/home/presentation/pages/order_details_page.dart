import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/core/util/core_helper_functions.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/cars/data/model/car_model.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/home/domain/usecase/set_driver_use_case.dart';

import 'package:naqla_driver/features/home/presentation/state/home_bloc.dart';
import 'package:naqla_driver/features/home/presentation/widgets/cars_card.dart';
import 'package:naqla_driver/features/orders/presentation/widgets/location_map.dart';

import '../../../../generated/l10n.dart';

class OrderDetailsPage extends StatelessWidget {
  OrderDetailsPage({super.key, required this.subOrderModel});
  final SubOrderModel subOrderModel;

  static String path = "OrderDetailsPage";
  static String name = "OrderDetailsPage";
  CarModel? carModel;

  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeBloc>(),
      child: AppScaffold(
          bottomNavigationBar: Padding(
            padding: REdgeInsets.all(10),
            child: BlocSelector<HomeBloc, HomeState, CommonState>(
              selector: (state) => state.getState(HomeState.setDriver),
              builder: (context, state) {
                return AppButton.dark(
                  isLoading: state.isLoading,
                  title: S.of(context).accept_order,
                  onPressed: () {
                    if (carModel == null) {
                      showMessage(S.of(context).pick_a_car);
                      _controller.animateTo(_controller.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 1), curve: Curves.fastOutSlowIn);
                    } else {
                      context
                          .read<HomeBloc>()
                          .add(SetDriverEvent(param: SetDriverParam(id: subOrderModel.id, carId: carModel!.id), onSuccess: () => context.pop()));
                    }
                  },
                );
              },
            ),
          ),
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).order_details),
          ),
          body: SingleChildScrollView(
            controller: _controller,
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: UIConstants.screenPadding30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocationMap(
                    locationStart: subOrderModel.order!.locationStart!,
                    locationEnd: subOrderModel.order!.locationEnd!,
                    height: 200.h,
                  ),
                  10.verticalSpace,
                  Container(
                    width: double.infinity,
                    padding: REdgeInsets.all(10),
                    decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                    child: RichText(
                      text: TextSpan(style: context.textTheme.subHeadMedium.copyWith(color: context.colorScheme.primary), children: [
                        TextSpan(text: '${S.of(context).weight}${subOrderModel.weight},'),
                        WidgetSpan(child: 5.horizontalSpace),
                        TextSpan(text: '${S.of(context).cost}${formatter.format(subOrderModel.cost)} ${S.of(context).syp},'),
                        if ((subOrderModel.order?.porters ?? 0) > 0) ...{
                          WidgetSpan(child: 5.horizontalSpace),
                          TextSpan(text: '${S.of(context).the_number_of_floors}: ${(subOrderModel.order?.porters ?? 1) - 1}'),
                        },
                        TextSpan(
                            text:
                                '\n${S.of(context).order_date}: ${CoreHelperFunctions.fromOrderDateTimeToString(subOrderModel.order!.desiredDate!)}'),
                        TextSpan(
                            text:
                                '\n${S.of(context).required_advantages}: ${(subOrderModel.order?.advantages?.isEmpty ?? true) ? S.of(context).there_are_no_advantages : subOrderModel.order?.advantages}'),
                      ]),
                    ),
                  ),
                  16.verticalSpace,
                  if (subOrderModel.photos.isNotEmpty) AppText.subHeadWebMedium(S.of(context).photos),
                  8.verticalSpace,
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200.h,
                          // width: ,
                          decoration: BoxDecoration(border: Border.all(color: context.colorScheme.outline), borderRadius: BorderRadius.circular(8)),
                          child: Center(child: AppImage.network(subOrderModel.photos[index].mobileUrl)),
                        );
                      },
                      separatorBuilder: (context, index) => 10.verticalSpace,
                      itemCount: subOrderModel.photos.length),
                  16.verticalSpace,
                  AppText.titleSmall(S.of(context).pick_a_car),
                  6.verticalSpace,
                  SizedBox(
                    height: 200.h,
                    child: CarsCard(
                      id: subOrderModel.order!.id,
                      onSelected: (p0) {
                        carModel = p0;
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
