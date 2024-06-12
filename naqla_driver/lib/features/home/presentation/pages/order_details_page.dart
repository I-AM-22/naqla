import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/home/data/model/car_model.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/home/domain/usecase/set_driver_use_case.dart';

import 'package:naqla_driver/features/home/presentation/state/home_bloc.dart';
import 'package:naqla_driver/features/home/presentation/widgets/cars_card.dart';

import '../../../../generated/l10n.dart';

class OrderDetailsPage extends StatelessWidget {
  OrderDetailsPage({super.key, required this.subOrderModel});
  final SubOrderModel subOrderModel;

  static String path = "OrderDetailsPage";
  static String name = "OrderDetailsPage";
  CarModel? carModel;

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
                    } else {
                      context
                          .read<HomeBloc>()
                          .add(SetDriverEvent(param: SetDriverParam(id: subOrderModel.id, carModel: carModel!), onSuccess: () => context.pop()));
                    }
                  },
                );
              },
            ),
          ),
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).order_details),
          ),
          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: UIConstants.screenPadding30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.titleSmall(S.of(context).pick_a_car),
                6.verticalSpace,
                CarsCard(
                  onSelected: (p0) {
                    carModel = p0;
                  },
                ),
                AppText.subHeadWebMedium('${S.of(context).weight}${subOrderModel.weight}'),
                16.verticalSpace,
                AppText.subHeadWebMedium('${S.of(context).cost}${subOrderModel.cost}'),
                10.verticalSpace,
                AppText.bodySmMedium('${S.of(context).porters}${subOrderModel.order.porters.toString()}'),
                16.verticalSpace,
                if (subOrderModel.photos.isNotEmpty) AppText.subHeadWebMedium(S.of(context).photos),
                8.verticalSpace,
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200.h,
                          // width: ,
                          decoration: BoxDecoration(border: Border.all(color: context.colorScheme.outline), borderRadius: BorderRadius.circular(8)),
                          child: BlurHash(
                              imageFit: BoxFit.contain, hash: subOrderModel.photos[index].blurHash, image: subOrderModel.photos[index].profileUrl),
                        );
                      },
                      separatorBuilder: (context, index) => 10.verticalSpace,
                      itemCount: subOrderModel.photos.length),
                )
              ],
            ),
          )),
    );
  }
}
