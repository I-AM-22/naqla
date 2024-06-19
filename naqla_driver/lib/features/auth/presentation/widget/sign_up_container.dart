import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/auth/domain/usecases/signup_use_case.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../pages/phone_verfication.dart';
import '../state/auth_bloc.dart';

class SignUpContainer extends StatefulWidget {
  const SignUpContainer({super.key});

  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Container(
        padding: REdgeInsets.symmetric(
          horizontal: UIConstants.screenPadding30,
        ),
        width: 1.sw,
        height: .9.sh,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.r),
            topRight: Radius.circular(50.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText.displayMedium(
                S.of(context).create_an_account,
                color: context.colorScheme.systemGray.shade900,
              ),
              40.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AppTextFormField(
                      name: 'firstName',
                      validator: FormBuilderValidators.required(),
                      hintText: S.of(context).first_name,
                    ),
                  ),
                  5.horizontalSpace,
                  Expanded(
                    child: AppTextFormField(
                      keyboardType: TextInputType.name,
                      validator: FormBuilderValidators.required(),
                      name: 'lastName',
                      hintText: S.of(context).last_name,
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              AppTextFormField(
                name: 'mobileNumber',
                hintText: S.of(context).your_mobile_number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(10),
                ]),
                maxLength: 10,
                keyboardType: TextInputType.phone,
              ),
              32.verticalSpace,
              BlocSelector<AuthBloc, AuthState, CommonState>(
                selector: (state) => state.getState(AuthState.signUp),
                builder: (context, state) {
                  return AppButton.dark(
                    isLoading: state.isLoading,
                    title: S.of(context).register,
                    onPressed: () async {
                      _formKey.currentState?.save();
                      _formKey.currentState?.validate();
                      if (_formKey.currentState?.isValid ?? false) {
                        context.read<AuthBloc>().add(SignUpEvent(
                              param: SignUpParam(
                                  phoneNumber: _formKey.currentState?.value['mobileNumber'],
                                  firstName: _formKey.currentState?.value['firstName'],
                                  lastName: _formKey.currentState?.value['lastName']),
                              onSuccess: () {
                                context.pushNamed(PhoneVerificationPage.name);
                              },
                            ));
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
  }
}
