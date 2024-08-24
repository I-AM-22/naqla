import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/auth/domain/usecases/login_use_case.dart';
import 'package:naqla_driver/features/auth/presentation/pages/phone_verfication.dart';
import 'package:naqla_driver/features/auth/presentation/pages/sign_up_page.dart';

import '../../../../core/common/constants/constants.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../generated/l10n.dart';
import '../state/auth_bloc.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding30),
          width: 1.sw,
          height: 513.h,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              topRight: Radius.circular(50.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText.displayMedium(
                S.of(context).Welcome,
                color: context.colorScheme.systemGray.shade900,
              ),
              40.verticalSpace,
              AppTextFormField(
                name: 'mobileNumber',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(10),
                ]),
                maxLength: 10,
                keyboardType: TextInputType.phone,
                hintText: S.of(context).your_mobile_number,
              ),
              32.verticalSpace,
              BlocSelector<AuthBloc, AuthState, CommonState>(
                selector: (state) => state.getState(AuthState.login),
                builder: (context, state) {
                  return AppButton.dark(
                    isLoading: state.isLoading,
                    title: S.of(context).sign_in,
                    onPressed: () async {
                      _formKey.currentState?.save();
                      _formKey.currentState?.validate();
                      if (_formKey.currentState?.isValid ?? false) {
                        context.read<AuthBloc>().add(LoginEvent(
                              param: LoginParam(phoneNumber: _formKey.currentState?.value['mobileNumber']),
                              onSuccess: () {
                                context.pushNamed(PhoneVerificationPage.name);
                              },
                            ));
                      }
                    },
                  );
                },
              ),
              23.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: AppText.bodyMedium(S.of(context).do_not_have_an_account, color: context.colorScheme.systemGray.shade700),
                  ),
                  Flexible(
                    flex: 2,
                    child: TextButton(
                        onPressed: () => context.pushNamed(SignUpPage.name),
                        child: AppText.bodyMedium(
                          S.of(context).sign_up,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
