import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/auth/presentation/pages/registration/phone_verfication.dart';
import 'package:naqla/features/auth/presentation/pages/registration/register_page.dart';
import 'package:naqla/features/auth/presentation/widgets/custom_social.dart';

import '../../../../generated/l10n.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.showTextButton});
  final bool showTextButton;

  static String get path => '/SignInPage';
  static String get name => '/SignInPage';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(
          back: true,
          appBarParams: AppBarParams(),
        ),
        body: Padding(
          padding: UIConstants.screenPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.titleMedium(S.of(context).log_in),
                30.verticalSpace,
                FormBuilder(
                  key: _formKey,
                  child: AppTextFormField(
                    hintText: S.of(context).your_mobile_number,
                    keyboardType: TextInputType.number,
                    // valueTransformer: (value) {
                    //   String manimbulatedValue = '$value';
                    //   return manimbulatedValue;
                    // },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(10)
                    ]),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                  ),
                ),
                40.verticalSpace,
                RSizedBox(
                  width: double.infinity.w,
                  child: AppButton.dark(
                    onPressed: () {
                      _formKey.currentState?.save();
                      _formKey.currentState?.validate();
                      if (_formKey.currentState?.isValid ?? false) {
                        context.pushNamed(PhoneVerificationPage.name);
                      }
                    },
                    stretch: true,
                    title: S.of(context).log_in,
                  ),
                ),
                20.verticalSpace,
                const WordDivider(),
                20.verticalSpace,
                const CustomSocial(),
                if (widget.showTextButton) ...{
                  28.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        child: AppText.bodyMedium(
                            S.of(context).do_not_have_an_account,
                            color: context.colorScheme.systemGray.shade700),
                      ),
                      Flexible(
                        flex: 2,
                        child: TextButton(
                            onPressed: () => context
                                .pushNamed(RegisterPage.name, extra: false),
                            child: AppText.bodyMedium(
                              S.of(context).sign_up,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                }
              ],
            ),
          ),
        ));
  }
}
