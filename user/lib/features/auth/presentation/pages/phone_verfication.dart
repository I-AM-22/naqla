import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/auth/domain/use_cases/confirm_use_case.dart';
import 'package:naqla/features/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:naqla/features/auth/presentation/widgets/verification_number.dart';

import '../../../../generated/l10n.dart';
import '../../../home/presentation/pages/home_page.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key, required this.phone});
  final String phone;

  static String get name => '/PhoneVerificationPage';

  static String get path => '/PhoneVerificationPage';

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final GlobalKey<FormBuilderState> _key = GlobalKey();
  String code = '';
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthBloc>(),
      child: AppScaffold(
          bottomNavigationBar: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: BlocSelector<AuthBloc, AuthState, CommonState>(
              selector: (state) => state.getState(AuthState.confirm),
              builder: (context, state) {
                return AppButton.dark(
                  isLoading: state.isLoading,
                  onPressed: () {
                    _key.currentState?.save();
                    _key.currentState?.validate();
                    if (code.isNotEmpty && code.length > 5) {
                      context.read<AuthBloc>().add(ConfirmEvent(ConfirmParam(otp: code, phone: widget.phone, false), (p0) {
                            context.goNamed(HomePage.name);
                          }));
                    }
                  },
                  stretch: true,
                  title: S.of(context).verify,
                  fixedSize: Size.fromHeight(48.h),
                );
              },
            ),
          ),
          appBar: AppAppBar(back: true, appBarParams: AppBarParams()),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: REdgeInsets.only(left: 50, right: 50, top: 30),
                child: Column(
                  children: [
                    AppText.titleMedium(
                      S.of(context).phone_verification,
                      textAlign: TextAlign.center,
                    ),
                    12.verticalSpace,
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: context.colorScheme.systemGray, fontSize: 16.sp),
                        children: [
                          TextSpan(text: S.of(context).enter_code),
                          TextSpan(text: S.of(context).otp),
                          TextSpan(text: S.of(context).your_code)
                        ],
                      ),
                    ),
                    40.verticalSpace,
                    FormBuilder(
                      key: _key,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return VerificationNumber(
                            onChanged: (code) {
                              this.code = code;
                            },
                            onCompleted: (val) {
                              context.read<AuthBloc>().add(ConfirmEvent(ConfirmParam(otp: val, phone: widget.phone, false), (p0) {
                                    context.goNamed(HomePage.name);
                                  }));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
