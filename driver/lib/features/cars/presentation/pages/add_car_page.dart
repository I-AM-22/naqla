import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/util/media_form_field.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/cars/domain/usecases/edit_car_use_case.dart';
import 'package:naqla_driver/features/cars/presentation/state/cars_bloc.dart';
import 'package:naqla_driver/features/cars/data/model/car_model.dart';
import 'package:naqla_driver/features/cars/presentation/widgets/color_car.dart';
import 'package:naqla_driver/features/cars/domain/usecases/add_car_use_case.dart';

import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/states/app_common_state_builder.dart';
import '../../data/model/car_advantage.dart';

class AddCaraParam {
  final CarModel? carModel;
  final CarsBloc bloc;

  AddCaraParam({this.carModel, required this.bloc});
}

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key, required this.param});
  final AddCaraParam param;

  static String path = "AddCarPage";
  static String name = "AddCarPage";

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final GlobalKey<FormBuilderState> _key = GlobalKey();

  @override
  void initState() {
    widget.param.bloc.add(GetCarAdvantageEvent(advantages: widget.param.carModel?.advantages));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.param.bloc,
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: isAdd ? S.of(context).add_car : S.of(context).edit),
          ),
          bottomNavigationBar: Padding(
            padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: 10),
            child: BlocSelector<CarsBloc, CarsState, CommonState>(
              selector: (state) => state.getState(widget.param.carModel == null ? CarsState.addCar : CarsState.editCar),
              builder: (context, state) {
                return AppButton.dark(
                  isLoading: state.isLoading,
                  title: widget.param.carModel != null ? S.of(context).edit : S.of(context).add_car,
                  onPressed: () {
                    _key.currentState?.save();
                    _key.currentState?.validate();
                    if (_key.currentState?.isValid ?? false) {
                      final param = AddCarParam(
                          color: _key.currentState?.value['color'],
                          brand: _key.currentState?.value[brand],
                          model: _key.currentState?.value[model],
                          photo: _key.currentState?.value[photo],
                          advantages: widget.param.bloc.state
                                  .getState<List<CarAdvantage>>(CarsState.carAdvantage)
                                  .data
                                  ?.where(
                                    (element) => element.isSelect,
                                  )
                                  .map(
                                    (e) => e.id,
                                  )
                                  .toList() ??
                              []);
                      if (isAdd) {
                        widget.param.bloc.add(
                          AddCarEvent(
                            param: param,
                            onSuccess: () {
                              context.pop();
                            },
                          ),
                        );
                      } else {
                        widget.param.bloc.add(
                          EditCarEvent(
                            param: EditCarParam(
                                color: param.color,
                                advantages: param.advantages,
                                brand: param.brand,
                                model: param.model,
                                photo: _key.currentState?.value[photo] == widget.param.carModel?.photo.mobileUrl
                                    ? null
                                    : _key.currentState?.value[photo],
                                id: widget.param.carModel!.id),
                            onSuccess: () {
                              context.pop();
                            },
                          ),
                        );
                      }
                    }
                  },
                );
              },
            ),
          ),
          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: UIConstants.screenPadding30),
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            title: S.of(context).model,
                            initialValue: widget.param.carModel?.model,
                            name: model,
                            validator: FormBuilderValidators.required(),
                          ),
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: AppTextFormField(
                            initialValue: widget.param.carModel?.brand,
                            title: S.of(context).brand,
                            name: brand,
                            validator: FormBuilderValidators.required(),
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    ColorCar(
                      color: widget.param.carModel?.color,
                    ),
                    16.verticalSpace,
                    MediaFormField(
                      name: photo,
                      initialValue: widget.param.carModel?.photo.mobileUrl,
                      width: context.fullWidth - 40.w,
                      title: S.of(context).photo,
                      height: 200.h,
                      validator: FormBuilderValidators.required(),
                      placeHolderDecoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: context.colorScheme.primary)),
                    ),
                    16.verticalSpace,
                    AppText.bodySmMedium(S.of(context).additional_specifications_of_the_car),
                    8.verticalSpace,
                    AppCommonStateBuilder<CarsBloc, List<CarAdvantage>>(
                      stateName: CarsState.carAdvantage,
                      onEmpty: Center(child: AppText.subHeadMedium(S.of(context).there_is_nothing_to_show)),
                      onSuccess: (data) => Padding(
                        padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: 10),
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
                                  widget.param.bloc.add(ChangeSelectAdvantageEvent(carAdvantage: data[index]));
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
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  String get model => "model";

  String get brand => "brand";

  String get photo => "photo";

  bool get isAdd => widget.param.carModel == null;
}
