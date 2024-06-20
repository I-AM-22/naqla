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
import 'package:naqla/core/global_widgets/app_date_picker.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/home/data/model/car_advantage.dart';
import 'package:naqla/features/home/data/model/location_model.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/features/home/presentation/pages/order_photos_page.dart';
import 'package:naqla/features/home/presentation/widget/end_location_card.dart';
import 'package:naqla/features/home/presentation/widget/start_location_card.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../generated/l10n.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  static const String path = "CreateOrderPage";
  static const String name = "CreateOrderPage";

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final ValueNotifier<bool> porters = ValueNotifier(false);
  final GlobalKey<FormBuilderState> _key = GlobalKey();
  final HomeBloc _bloc = getIt<HomeBloc>();
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    _bloc.add(GetCarAdvantageEvent());
    super.initState();
  }

  int _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: AppScaffold(
        bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: REdgeInsets.symmetric(
                  horizontal: UIConstants.screenPadding16, vertical: 10),
              child: AppButton.dark(
                title: S.of(context).next,
                onPressed: () {
                  _key.currentState?.save();
                  _key.currentState?.validate();
                  if (_key.currentState?.isValid ?? false) {
                    context.read<HomeBloc>().add(SetOrderParamEvent(
                        desiredDate: dateTime.toIso8601String(),
                        locationStart: LocationModel(
                          region: _key.currentState?.value['region'],
                          street: _key.currentState?.value['street'],
                          latitude:
                              _key.currentState?.value['startPoint'].latitude ??
                                  0,
                          longitude: _key.currentState?.value['startPoint']
                                  .longitude ??
                              0,
                        ),
                        locationEnd: LocationModel(
                          latitude:
                              _key.currentState?.value['endPoint'].latitude ??
                                  0,
                          longitude:
                              _key.currentState?.value['endPoint'].longitude ??
                                  0,
                          street: _key.currentState?.value['street2'],
                          region: _key.currentState?.value['region2'],
                        ),
                        porters: porters.value ? _currentValue + 1 : 0,
                        advantages: state
                            .getState<List<CarAdvantage>>(
                                HomeState.carAdvantage)
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
        ),
        appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).new_naqla)),
        body: SingleChildScrollView(
          padding:
              REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
          child: FormBuilder(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StartLocationCard(),
                16.verticalSpace,
                const EndLocationCard(),
                16.verticalSpace,
                AppDatePicker(
                  title: S.of(context).order_delivered_date,
                  validator: FormBuilderValidators.required(
                      errorText: S.of(context).this_field_is_required),
                  name: 'date',
                  onDateTimeChanged: (p0) => dateTime = p0,
                  minimumDate: DateTime.now(),
                ),
                20.verticalSpace,
                Row(
                  children: [
                    ValueListenableBuilder(
                      builder: (context, value, _) => AppCheckbox(
                        isSelected: value,
                        onChanged: (value) {
                          porters.value = value;
                          setState(() {});
                        },
                      ),
                      valueListenable: porters,
                    ),
                    8.horizontalSpace,
                    AppText.bodySmMedium(
                      S.of(context).porters,
                      color: Colors.black,
                    )
                  ],
                ),
                11.verticalSpace,
                AppText.bodySmMedium(S
                    .of(context)
                    .the_remuneration_will_depend_on_the_number_of_porters_required),
                10.verticalSpace,
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: porters.value ? 1 : 0,
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 1000),
                    child: porters.value
                        ? Row(
                            children: [
                              Flexible(
                                  child: AppText.titleSmall(
                                      S.of(context).total_number_of_floors)),
                              10.horizontalSpace,
                              NumberPicker(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: context.colorScheme.outline),
                                    borderRadius: BorderRadius.circular(8)),
                                value: _currentValue,
                                textStyle: context.textTheme.bodySmMedium,
                                minValue: 0,
                                maxValue: 100,
                                onChanged: (value) =>
                                    setState(() => _currentValue = value),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                ),
                18.verticalSpace,
                AppText.bodySmMedium(
                  S.of(context).additional_specifications_of_the_car,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                AppCommonStateBuilder<HomeBloc, List<CarAdvantage>>(
                  stateName: HomeState.carAdvantage,
                  onEmpty: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: AppText.subHeadMedium(
                            S.of(context).there_is_nothing_to_show)),
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
                                  ChangeSelectAdvantageEvent(
                                      carAdvantage: data[index]));
                            },
                          ),
                          8.horizontalSpace,
                          Text.rich(
                              style: context.textTheme.bodySmMedium,
                              TextSpan(children: [
                                TextSpan(text: data[index].name),
                                WidgetSpan(child: 4.horizontalSpace),
                                TextSpan(
                                    text:
                                        "[${data[index].cost} ${S.of(context).syp}]")
                              ])),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
