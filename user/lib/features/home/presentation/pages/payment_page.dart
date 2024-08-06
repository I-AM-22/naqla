import 'package:common_state/common_state.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/domain/repository/prefs_repository.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/home/domain/use_case/accept_order_use_case.dart';
import 'package:naqla/features/home/presentation/bloc/home_bloc.dart';
import 'package:naqla/features/home/presentation/pages/home_page.dart';
import '../../../../core/common/constants/constants.dart';
import '../../../../core/common/enums/credit_card_field.dart';
import '../../../../core/di/di_container.dart';
import '../../../../core/util/masked_input_formatter.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/data/model/user_model.dart';
import '../widget/credit_card_field_blinker.dart';
import '../widget/credit_card_widget.dart';

class AddCardPageMobile extends StatefulWidget {
  const AddCardPageMobile({
    super.key,
    required this.param,
  });

  final AcceptOrderParam param;

  static String path = "AddCardPageMobile";
  static String name = "AddCardPageMobile";

  @override
  State<AddCardPageMobile> createState() => _AddCardPageMobileState();
}

class _AddCardPageMobileState extends State<AddCardPageMobile> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  User? user;

  final ValueNotifier<CreditCardField?> _blinkField = ValueNotifier<CreditCardField?>(null);

  late final AnimationController _animationController;
  final Map<CreditCardField, Set> _cardFieldsProperties = {
    CreditCardField.cardNumber: {
      FocusNode(),
      ValueNotifier<String>(''),
    },
    CreditCardField.expiryDate: {
      FocusNode(),
      ValueNotifier<String>(''),
    },
    CreditCardField.holderName: {
      FocusNode(),
      ValueNotifier<String>(''),
    },
  };

  @override
  void initState() {
    user = getIt<PrefsRepository>().user;
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _blinkManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        appBarParams: AppBarParams(),
      ),
      body: BlocProvider.value(
        value: getIt<HomeBloc>(),
        child: Builder(builder: (context) {
          return FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: REdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: context.colorScheme.blue,
                          boxShadow: [BoxShadow(color: context.colorScheme.outline, blurRadius: 5, offset: const Offset(0, 2))]),
                      child: CreditCardWidget(
                        numberWidget: ValueListenableBuilder(
                          valueListenable: _cardFieldsProperties[CreditCardField.cardNumber]!.last as ValueNotifier<String>,
                          builder: (context, value, child) {
                            return CreditCardFieldBlinker(
                              animationController: _animationController,
                              blinkField: _blinkField,
                              field: CreditCardField.cardNumber,
                              widget: AppText(
                                value + '---- ---- ---- ----'.substring(value.length),
                                color: context.colorScheme.surface,
                                style: boldWIthShadow(context),
                              ),
                            );
                          },
                        ),
                        holderNameWidget: CreditCardFieldBlinker(
                          animationController: _animationController,
                          blinkField: _blinkField,
                          field: CreditCardField.holderName,
                          widget: ValueListenableBuilder(
                            valueListenable: _cardFieldsProperties[CreditCardField.holderName]!.last as ValueNotifier<String>,
                            builder: (BuildContext context, String value, Widget? child) {
                              return Container(
                                constraints: BoxConstraints(maxWidth: context.fullWidth * .38),
                                child: AppText.headlineSmall(
                                  value.isEmpty ? 'John Carter' : value,
                                  overflow: TextOverflow.ellipsis,
                                  color: context.colorScheme.surface,
                                  style: boldWIthShadow(context),
                                ),
                              );
                            },
                          ),
                        ),
                        expiryDateWidget: CreditCardFieldBlinker(
                          animationController: _animationController,
                          blinkField: _blinkField,
                          field: CreditCardField.expiryDate,
                          widget: ValueListenableBuilder(
                            valueListenable: _cardFieldsProperties[CreditCardField.expiryDate]!.last as ValueNotifier<String>,
                            builder: (context, value, child) {
                              return AppText.headlineSmall(
                                value + '--/--'.substring(value.length),
                                color: context.colorScheme.surface,
                                style: boldWIthShadow(context),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    30.verticalSpace,
                    Container(
                      padding: REdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: context.colorScheme.shadow.withOpacity(.2),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          AppTextFormField(
                            name: 'cardHolderKey',
                            hintText: S.of(context).card_name_for_display,
                            onChanged: (value) {
                              _cardFieldsProperties[CreditCardField.holderName]!.last.value = value;
                            },
                            focusNode: _cardFieldsProperties[CreditCardField.holderName]!.first,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: S.of(context).this_field_is_required),
                              (val) {
                                if (val != null && !RegExp(r'^((?:[A-Za-z]+ ?){1,3})$').hasMatch(val)) {
                                  return S.of(context).Invalid_card_holder_name;
                                }
                                return null;
                              },
                              FormBuilderValidators.minLength(5, errorText: S.of(context).the_name_must_be_at_least_characters_long(5)),
                            ]),
                          ),
                          16.verticalSpace,
                          AppTextFormField(
                            name: 'numberKey',
                            hintText: S.of(context).card_Number,
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: S.of(context).this_field_is_required),
                              FormBuilderValidators.minLength(16, errorText: S.of(context).the_card_number_must_consist_of_digits(16)),
                              (val) {
                                var ss = detectCCType(_formKey.currentState?.instantValue['numberKey']);
                                if (ss.isEmpty) {
                                  return S.of(context).not_valid_number;
                                }
                                return null;
                              }
                            ]),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(19),
                              MaskedTextInputFormatter(mask: 'xxxx xxxx xxxx xxxx', separator: ' ')
                            ],
                            onChanged: (value) => _cardFieldsProperties[CreditCardField.cardNumber]!.last.value = value,
                            focusNode: _cardFieldsProperties[CreditCardField.cardNumber]!.first,
                          ),
                          16.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: AppTextFormField(
                                  name: 'expiryDateKey',
                                  hintText: 'MM/YY',
                                  validator: FormBuilderValidators.compose(
                                    [
                                      FormBuilderValidators.match(RegExp(r"^(0[1-9]|1[0-2])/([0-9]{2})$"), errorText: S.of(context).not_a_valid_date),
                                      FormBuilderValidators.required(errorText: S.of(context).this_field_is_required),
                                      (value) {
                                        List<String>? dateComponents = value?.split('/');
                                        int expiryMonth = int.parse(dateComponents?[0] ?? '');
                                        int expiryYear = int.parse("20${dateComponents?[1]}");
                                        DateTime cardExpiryDate = DateTime(expiryYear, expiryMonth);
                                        if (cardExpiryDate.isBefore(DateTime.now())) {
                                          return S.of(context).enter_larger_date;
                                        }
                                        return null;
                                      },
                                    ],
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(5),
                                    MaskedTextInputFormatter(mask: 'xx/xx', separator: '/'),
                                  ],
                                  onChanged: (value) => _cardFieldsProperties[CreditCardField.expiryDate]!.last.value = value,
                                  focusNode: _cardFieldsProperties[CreditCardField.expiryDate]!.first,
                                ),
                              ),
                              16.horizontalSpace,
                              Expanded(
                                child: AppTextFormField(
                                  name: 'cvvKey',
                                  hintText: 'CVV',
                                  keyboardType: TextInputType.number,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(errorText: S.of(context).this_field_is_required),
                                    FormBuilderValidators.minLength(4, errorText: S.of(context).length_should_more(4)),
                                  ]),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(4),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    32.verticalSpace,
                    BlocSelector<HomeBloc, HomeState, CommonState>(
                      selector: (state) => state.getState(HomeState.acceptOrder),
                      builder: (context, state) {
                        return AppButton.dark(
                          title: S.of(context).the_total_amount(formatter.format(widget.param.cost)),
                          buttonSize: ButtonSize.large,
                          textStyle: context.textTheme.bodySmMedium.copyWith(color: Colors.white),
                          isLoading: state.isLoading,
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<HomeBloc>().add(
                                    AcceptOrderEvent(
                                      onSuccess: () {
                                        context.goNamed(HomePage.name);
                                      },
                                      param: widget.param.copyWith(userId: user?.id),
                                    ),
                                  );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  TextStyle boldWIthShadow(BuildContext context) => context.textTheme.titleMedium!.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: .4,
        shadows: [
          Shadow(
            color: context.colorScheme.shadow.withOpacity(.4),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      );

  void _blinkManager() {
    for (var focusNode in _cardFieldsProperties.values.map<FocusNode>((e) => e.first)) {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          // Set the currently focused field for blinking animation
          _blinkField.value = _cardFieldsProperties.entries.firstWhere((element) => element.value.first == focusNode).key;
          _animationController.repeat(reverse: true, min: .3);
        } else if (_cardFieldsProperties.values.every((element) => !element.first.hasFocus)) {
          // Stop the blinking animation when no field has focus
          _animationController.stop();
          _blinkField.value = null;
        }
      });
    }
  }
}
