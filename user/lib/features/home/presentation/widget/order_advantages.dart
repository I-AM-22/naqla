import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/home/data/model/car_advantage.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/generated/l10n.dart';

class OrderAdvantages extends StatelessWidget {
  const OrderAdvantages({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCommonStateBuilder<HomeBloc, List<CarAdvantage>>(
      stateName: HomeState.carAdvantage,
      onEmpty: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child:
                AppText.subHeadMedium(S.of(context).there_is_nothing_to_show)),
      ),
      onSuccess: (data) => Padding(
        padding: REdgeInsets.symmetric(
            horizontal: UIConstants.screenPadding16, vertical: 10),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          separatorBuilder: (context, index) => 14.verticalSpace,
          itemBuilder: (context, index) => Row(
            children: [
              AppCheckbox(
                isSelected: data[index].isSelect,
                onChanged: (value) {
                  context.read<HomeBloc>().add(
                      ChangeSelectAdvantageEvent(carAdvantage: data[index]));
                },
              ),
              8.horizontalSpace,
              Text.rich(
                  style: context.textTheme.bodySmMedium,
                  TextSpan(children: [
                    TextSpan(text: data[index].name),
                    WidgetSpan(child: 4.horizontalSpace),
                    TextSpan(text: "[${data[index].cost} ${S.of(context).syp}]")
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
