import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/home/data/model/car_advantage.dart';
import 'package:naqla/features/home/data/model/location_model.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/features/home/presentation/pages/order_photos_page.dart';
import 'package:naqla/generated/l10n.dart';

class FirstStepCreateOrderButton extends StatelessWidget {
  const FirstStepCreateOrderButton(
      {super.key,
      required this.formKey,
      required this.dateTime,
      required this.porters,
      required this.currentValue});
  final GlobalKey<FormBuilderState> formKey;
  final DateTime dateTime;
  final bool porters;
  final int currentValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: REdgeInsets.symmetric(
              horizontal: UIConstants.screenPadding16, vertical: 10),
          child: AppButton.dark(
            title: S.of(context).next,
            onPressed: () {
              formKey.currentState?.save();
              formKey.currentState?.validate();
              if (formKey.currentState?.isValid ?? false) {
                context.read<HomeBloc>().add(SetOrderParamEvent(
                    desiredDate: dateTime.toIso8601String(),
                    locationStart: LocationModel(
                      region: formKey.currentState?.value['region'],
                      street: formKey.currentState?.value['street'],
                      latitude:
                          formKey.currentState?.value['startPoint'].latitude ??
                              0,
                      longitude:
                          formKey.currentState?.value['startPoint'].longitude ??
                              0,
                    ),
                    locationEnd: LocationModel(
                      latitude:
                          formKey.currentState?.value['endPoint'].latitude ?? 0,
                      longitude:
                          formKey.currentState?.value['endPoint'].longitude ??
                              0,
                      street: formKey.currentState?.value['street2'],
                      region: formKey.currentState?.value['region2'],
                    ),
                    porters: porters ? currentValue + 1 : 0,
                    advantages: state
                        .getState<List<CarAdvantage>>(HomeState.carAdvantage)
                        .data
                        ?.where((element) => element.isSelect)
                        .map((e) => e.id)
                        .toList()));
                context.pushNamed(OrderPhotosPage.name);
              }
            },
          ),
        );
      },
    );
  }
}
