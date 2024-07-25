import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/orders/domain/usecases/rating_use_case.dart';
import 'package:naqla/features/orders/presentation/state/order_bloc.dart';
import 'package:naqla/features/orders/presentation/widgets/rate_widget.dart';

import '../../../../generated/l10n.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key, required this.id});
  final String id;

  static String path = "RatingPage";

  static String name = "RatingPage";

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  ValueNotifier<int> rateServicesNotifier = ValueNotifier(1);
  int rate = 1;
  final OrderBloc bloc = getIt<OrderBloc>();
  final GlobalKey<FormBuilderState> _key = GlobalKey();
  final ValueNotifier<bool> repeatDriver = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).rate_the_driver),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: UIConstants.screenPadding30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RateWidget(
                    ratingNotifier: rateServicesNotifier,
                    onTap: (index) {
                      rate = index + 1;
                      setState(() {});
                    },
                  ),
                  16.verticalSpace,
                  FormBuilder(
                    key: _key,
                    child: AppTextFormField(
                      title: S.of(context).notes,
                      name: 'note',
                      textInputAction: TextInputAction.newline,
                      hintText: S.of(context).write_a_comment_note,
                      minLines: 5,
                      maxLines: 10,
                      validator: FormBuilderValidators.required(),
                    ),
                  ),
                  16.verticalSpace,
                  AppText.bodyMedium('هل سوف تتعامل مع نفس السائق في المرات القادمة؟'),
                  8.verticalSpace,
                  Row(
                    children: [
                      ValueListenableBuilder(
                        builder: (context, value, _) => AppCheckbox(
                          isSelected: value,
                          onChanged: (value) {
                            if (!value) return;

                            repeatDriver.value = value;
                            setState(() {});
                          },
                        ),
                        valueListenable: repeatDriver,
                      ),
                      8.horizontalSpace,
                      AppText.bodySmMedium(
                        S.of(context).yes,
                        color: Colors.black,
                      ),
                      16.horizontalSpace,
                      ValueListenableBuilder(
                        builder: (context, value, _) => AppCheckbox(
                          isSelected: !value,
                          onChanged: (value) {
                            if (!value) return;
                            repeatDriver.value = !value;
                            setState(() {});
                          },
                        ),
                        valueListenable: repeatDriver,
                      ),
                      8.horizontalSpace,
                      AppText.bodySmMedium(
                        S.of(context).no,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  BlocSelector<OrderBloc, OrderState, CommonState>(
                    selector: (state) {
                      return state.getState(OrderState.rating);
                    },
                    builder: (context, state) {
                      return AppButton.dark(
                        isLoading: state.isLoading,
                        title: S.of(context).Save,
                        stretch: true,
                        onPressed: () {
                          _key.currentState?.save();
                          _key.currentState?.validate();
                          if (_key.currentState?.isValid ?? false) {
                            bloc.add(
                              RatingEvent(
                                onSuccess: () => context.pop(),
                                param: RatingParam(
                                  id: widget.id,
                                  notes: _key.currentState?.value['note'],
                                  repeatDriver: repeatDriver.value,
                                  rating: rate,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
