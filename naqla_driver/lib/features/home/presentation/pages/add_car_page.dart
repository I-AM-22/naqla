import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/core/util/media_form_field.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/home/domain/usecase/add_car_use_case.dart';

import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/states/app_common_state_builder.dart';
import '../../data/model/car_advantage.dart';
import '../state/home_bloc.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  static String path = "AddCarPage";
  static String name = "AddCarPage";

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  // create some values
  Color pickerColor = const Color(0xff443a49);
  Color? currentColor;

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  final HomeBloc bloc = getIt<HomeBloc>();
  final GlobalKey<FormBuilderState> _key = GlobalKey();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    bloc.add(GetCarAdvantageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).add_car),
          ),
          bottomNavigationBar: Padding(
            padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: 10),
            child: BlocSelector<HomeBloc, HomeState, CommonState>(
              selector: (state) => state.getState(HomeState.addCar),
              builder: (context, state) {
                return AppButton.dark(
                  isLoading: state.isLoading,
                  title: S.of(context).add_car,
                  onPressed: () {
                    _key.currentState?.save();
                    _key.currentState?.validate();
                    if ((_key.currentState?.isValid ?? false) && currentColor != null) {
                      bloc.add(
                        AddCarEvent(
                          param: AddCarParam(
                              color: _key.currentState?.value[color],
                              brand: _key.currentState?.value[brand],
                              model: _key.currentState?.value[model],
                              photo: _key.currentState?.value[photo],
                              advantages: bloc.state
                                      .getState<List<CarAdvantage>>(HomeState.carAdvantage)
                                      .data
                                      ?.where(
                                        (element) => element.isSelect,
                                      )
                                      .map(
                                        (e) => e.id,
                                      )
                                      .toList() ??
                                  []),
                          onSuccess: () {
                            context.pop();
                          },
                        ),
                      );
                    } else if (currentColor == null) {
                      showMessage(S.of(context).pick_a_color);
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
                            name: model,
                            validator: FormBuilderValidators.required(),
                          ),
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: AppTextFormField(
                            title: S.of(context).brand,
                            name: brand,
                            validator: FormBuilderValidators.required(),
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    SizedBox(
                      width: (context.fullWidth / 2) - 16.w,
                      child: AppTextFormField(
                        key: const ObjectKey('colors'),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: currentColor ?? context.colorScheme.primary)),
                        title: S.of(context).color,
                        style: TextStyle(color: currentColor),
                        name: color,
                        // initialValue: currentColor?.value.toString(),
                        controller: controller,
                        readOnly: true,
                        validator: FormBuilderValidators.required(),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: AppText(S.of(context).pick_a_color),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: changeColor,
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: AppText(S.of(context).Save),
                                  onPressed: () {
                                    setState(() {
                                      currentColor = pickerColor;
                                      controller.text = currentColor?.value.toRadixString(16) ?? '';
                                    });

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    16.verticalSpace,
                    MediaFormField(
                      name: photo,
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
                    AppCommonStateBuilder<HomeBloc, List<CarAdvantage>>(
                      stateName: HomeState.carAdvantage,
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
                                  context.read<HomeBloc>().add(ChangeSelectAdvantageEvent(carAdvantage: data[index]));
                                },
                              ),
                              8.horizontalSpace,
                              Text.rich(
                                  style: context.textTheme.bodySmMedium,
                                  TextSpan(children: [
                                    TextSpan(text: data[index].name),
                                    WidgetSpan(child: 4.horizontalSpace),
                                    TextSpan(text: "[${data[index].cost}]")
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
  String get color => "color";
  String get photo => "photo";
}
