import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/global_widgets/app_button.dart';
import 'package:naqla/features/home/domain/use_case/set_order_use_case.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/features/home/presentation/pages/home_page.dart';
import 'package:naqla/generated/l10n.dart';

class LastStepCreateOrderButton extends StatelessWidget {
  const LastStepCreateOrderButton({super.key, required this.formKey});
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Padding(
                padding: REdgeInsets.symmetric(
                    horizontal: UIConstants.screenPadding16, vertical: 10),
                child: AppButton.dark(
                  isLoading: state.getState(HomeState.setOrder).isLoading,
                  title: S.of(context).next,
                  onPressed: () {
                    formKey.currentState?.save();
                    formKey.currentState?.validate();
                    if (formKey.currentState?.isValid ?? false) {
                      context.read<HomeBloc>().add(SetOrderParamEvent(
                              items: List<OrderItemsParam>.generate(
                            state.formCount,
                            (index) => OrderItemsParam(
                                photo: formKey.currentState?.value['photo$index'],
                                width: formKey.currentState?.value['width$index'],
                                length:
                                    formKey.currentState?.value['length$index'],
                                weight:
                                    formKey.currentState?.value['weight$index']),
                          )));
                      context.read<HomeBloc>().add(SetOrderEvent(
                        onSuccess: () {
                          context.goNamed(HomePage.name);
                        },
                      ));
                    }
                  },
                ),
              );
            },
          );
  }
}