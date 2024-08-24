import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/cars/data/model/car_model.dart';
import 'package:naqla_driver/features/cars/presentation/state/cars_bloc.dart';

import '../../../../core/util/core_helper_functions.dart';
import '../../../../generated/l10n.dart';
import '../pages/add_car_page.dart';

class CarsSection extends StatelessWidget {
  const CarsSection({super.key, required this.carModel, required this.bloc});
  final CarModel carModel;
  final CarsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.colorScheme.outline)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          8.verticalSpace,
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 8),
            child: AppText.subHeadMedium(
                '${S.of(context).model}: ${carModel.model}'),
          ),
          16.verticalSpace,
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 8),
            child: AppText.subHeadMedium(
                '${S.of(context).brand}: ${carModel.brand}'),
          ),
          if (carModel.advantages.isNotEmpty) ...{
            16.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 8),
              child: AppText.subHeadMedium(
                  '${S.of(context).advantages}: ${carModel.advantages.map(
                        (e) => e.name,
                      ).toList()}'),
            ),
          },
          16.verticalSpace,
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                AppText.subHeadRegular(S.of(context).color),
                4.horizontalSpace,
                Container(
                  width: 100.w,
                  height: 20.h,
                  color: CoreHelperFunctions.hexToColor(carModel.color),
                )
              ],
            ),
          ),
          16.verticalSpace,
          SizedBox(
            height: 200.h,
            child: Center(child: AppImage.network(carModel.photo.mobileUrl)),
          ),
          16.verticalSpace,
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              border: Border(
                  top:
                      BorderSide(color: context.colorScheme.waiting, width: 2)),
            ),
            width: double.infinity,
            child: SizedBox(
              height: 50.h,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => context.pushNamed(AddCarPage.name,
                          extra: AddCaraParam(bloc: bloc, carModel: carModel)),
                      child: Center(
                        child: AppText.subHeadMedium(
                          S.of(context).edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    child: const VerticalDivider(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => CoreHelperFunctions.deleteCar(
                          context, carModel.id, bloc),
                      child: Center(
                        child: AppText.subHeadMedium(
                          S.of(context).delete,
                          color: context.colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
