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
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: context.colorScheme.outline)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.subHeadMedium('${S.of(context).model}: ${carModel.model}'),
          16.verticalSpace,
          AppText.subHeadMedium('${S.of(context).brand}: ${carModel.brand}'),
          16.verticalSpace,
          Row(
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
          16.verticalSpace,
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              border: Border.all(color: context.colorScheme.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: AppImage.network(carModel.photo.mobileUrl)),
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppButton.dark(
                  title: S.of(context).edit,
                  onPressed: () {
                    context.pushNamed(AddCarPage.name, extra: AddCaraParam(bloc: bloc, carModel: carModel));
                  },
                ),
              ),
              5.horizontalSpace,
              Expanded(
                child: AppButton.gray(
                  title: S.of(context).delete,
                  textStyle: TextStyle(color: context.colorScheme.error),
                  onPressed: () {
                    CoreHelperFunctions.deleteCar(context, carModel.id, bloc);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
