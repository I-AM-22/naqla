import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/config/themes/utils.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:naqla/features/auth/presentation/pages/registration/phone_verfication.dart';
import 'package:naqla/features/auth/presentation/pages/sign_in_page.dart';
import 'package:naqla/features/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:naqla/features/auth/presentation/widgets/custom_social.dart';
import 'package:naqla/generated/flutter_gen/assets.gen.dart';

import '../../../../../generated/l10n.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.showTextButton});
  final bool showTextButton;

  static String get name => '/RegisterPage';
  static String get path => '/RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthBloc>(),
      child: AppScaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppAppBar(back: true, appBarParams: AppBarParams()),
          body: Container(
            padding: REdgeInsets.symmetric(horizontal: kpPaddingPage),
            height: context.bodyHeight,
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppText.titleMedium(
                      S.of(context).create_an_account,
                    ),
                    30.verticalSpace,
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor:
                                context.colorScheme.systemGray.shade200,
                          ),
                          CircleAvatar(
                            backgroundColor: context.colorScheme.primary,
                            child: AppImage.asset(
                              Assets.icons.essential.camera.path,
                              size: 30.r,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            name: 'firstName',
                            hintText: S.of(context).first_name,
                            validator: FormBuilderValidators.required(),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: AppTextFormField(
                            name: 'lastName',
                            hintText: S.of(context).last_name,
                            validator: FormBuilderValidators.required(),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    AppTextFormField(
                      name: 'phoneNumber',
                      hintText: S.of(context).your_mobile_number,
                      valueTransformer: (value) {
                        String manimbulatedValue = '$value';
                        return manimbulatedValue;
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(10)
                      ]),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      keyboardType: TextInputType.phone,
                    ),
                    20.verticalSpace,
                    BlocSelector<AuthBloc, Map<int, CommonState>, CommonState>(
                      selector: (state) => state[AuthState.signUp]!,
                      builder: (context, state) {
                        return AppButton.dark(
                          isLoading: state.isLoading(),
                          onPressed: () {
                            _formKey.currentState?.save();
                            _formKey.currentState?.validate();
                            if (_formKey.currentState?.isValid ?? false) {
                              context.read<AuthBloc>().add(SignUpEvent(
                                  SignUpParam(
                                      phone: _formKey
                                          .currentState?.value['phoneNumber'],
                                      firstName: _formKey
                                          .currentState?.value['firstName'],
                                      lastName: _formKey
                                          .currentState?.value['lastName'],
                                      password: '123456'),
                                  (p0) => context
                                      .pushNamed(PhoneVerificationPage.name)));
                            }
                          },
                          stretch: true,
                          title: S.of(context).sign_up,
                          fixedSize: Size.fromHeight(48.h),
                        );
                      },
                    ),
                    20.verticalSpace,
                    const WordDivider(),
                    15.verticalSpace,
                    const CustomSocial(),
                    if (widget.showTextButton) ...{
                      40.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 3,
                            child: AppText.bodyMedium(
                                S.of(context).already_have_an_account,
                                color: context.colorScheme.systemGray.shade700),
                          ),
                          Flexible(
                            flex: 2,
                            child: TextButton(
                                onPressed: () => context
                                    .pushNamed(SignInPage.name, extra: false),
                                child: AppText.bodyMedium(
                                  S.of(context).log_in,
                                )),
                          )
                        ],
                      ),
                    },
                    20.verticalSpace
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
