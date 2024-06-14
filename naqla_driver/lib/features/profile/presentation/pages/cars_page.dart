import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/util/core_helper_functions.dart';
import 'package:naqla_driver/features/app/presentation/state/bloc/app_bloc.dart';
import 'package:naqla_driver/features/app/presentation/widgets/animated_dialog.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla_driver/features/home/data/model/car_model.dart';
import 'package:naqla_driver/features/home/presentation/pages/add_car_page.dart';

import '../../../../generated/l10n.dart';

class CarsPage extends StatelessWidget {
  const CarsPage({super.key});
  static String path = "CarsPage";

  static String name = "CarsPage";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(title: S.of(context).cars),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<AppBloc>().add(GetAllCarsEvent());
          },
          child: AppCommonStateBuilder<AppBloc, List<CarModel>>(
            stateName: AppState.getAllCars,
            onSuccess: (data) => ListView.separated(
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: UIConstants.screenPadding30),
                itemBuilder: (context, index) {
                  return Container(
                    padding: REdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: context.colorScheme.outline)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.subHeadMedium('${S.of(context).model}: ${data[index].model}'),
                        16.verticalSpace,
                        AppText.subHeadMedium('${S.of(context).brand}: ${data[index].brand}'),
                        16.verticalSpace,
                        Row(
                          children: [
                            AppText.subHeadRegular(S.of(context).color),
                            4.horizontalSpace,
                            Container(
                              width: 100.w,
                              height: 20.h,
                              color: CoreHelperFunctions.hexToColor(data[index].color),
                            )
                          ],
                        ),
                        16.verticalSpace,
                        Container(
                          height: 200.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: context.colorScheme.outline),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: BlurHash(
                            imageFit: BoxFit.contain,
                            hash: data[index].photo.blurHash,
                            image: data[index].photo.mobileUrl,
                          ),
                        ),
                        16.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: AppButton.dark(
                                title: S.of(context).edit,
                                onPressed: () {
                                  context.pushNamed(AddCarPage.profileName, extra: data[index]);
                                },
                              ),
                            ),
                            5.horizontalSpace,
                            Expanded(
                              child: AppButton.gray(
                                title: S.of(context).delete,
                                textStyle: TextStyle(color: context.colorScheme.error),
                                onPressed: () {
                                  AnimatedDialog.show(context,
                                      child: Padding(
                                        padding:
                                            REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: UIConstants.screenPadding20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AppText.subHeadRegular(S.of(context).delete_car),
                                            16.verticalSpace,
                                            AppText.subHeadMedium(S.of(context).are_you_sure_delete_this_car),
                                            16.verticalSpace,
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: AppButton.dark(
                                                  title: S.of(context).no,
                                                  onPressed: () {
                                                    context.pop();
                                                  },
                                                )),
                                                5.horizontalSpace,
                                                Expanded(
                                                    child: BlocSelector<AppBloc, AppState, CommonState>(
                                                  selector: (state) => state.getState(AppState.deleteCar),
                                                  builder: (context, state) {
                                                    return AppButton.gray(
                                                      isLoading: state.isLoading,
                                                      title: S.of(context).yes,
                                                      textStyle: TextStyle(color: context.colorScheme.error),
                                                      onPressed: () {
                                                        context.read<AppBloc>().add(DeleteCarEvent(
                                                              id: data[index].id,
                                                              onSuccess: () => context.pop(),
                                                            ));
                                                      },
                                                    );
                                                  },
                                                )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => 8.verticalSpace,
                itemCount: data.length),
          ),
        ));
  }
}
