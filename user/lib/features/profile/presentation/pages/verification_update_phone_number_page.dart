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
import 'package:naqla/features/auth/presentation/widgets/verification_number.dart';
import 'package:naqla/features/profile/presentation/pages/profile_page.dart';
import 'package:naqla/features/profile/presentation/state/bloc/profile_bloc.dart';

import '../../../../generated/l10n.dart';

class VerificationUpdatePhonePage extends StatefulWidget {
  const VerificationUpdatePhonePage({super.key, required this.phone});
  final String phone;

  static String get name => 'VerificationUpdatePhonePage';

  static String get path => 'VerificationUpdatePhonePage';

  @override
  State<VerificationUpdatePhonePage> createState() => _VerificationUpdatePhonePageState();
}

class _VerificationUpdatePhonePageState extends State<VerificationUpdatePhonePage> {
  final GlobalKey<FormBuilderState> _key = GlobalKey();
  String code = '';
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileBloc>(),
      child: AppScaffold(
          bottomNavigationBar: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: BlocSelector<ProfileBloc, ProfileState, CommonState>(
              selector: (state) => state.getState(ProfileState.confirm),
              builder: (context, state) {
                return AppButton.dark(
                  isLoading: state.isLoading,
                  onPressed: () {
                    _key.currentState?.save();
                    _key.currentState?.validate();
                    if (code.isNotEmpty && code.length > 5) {
                      context.read<ProfileBloc>().add(ConfirmEvent(
                          param: ConfirmParam(otp: code, phone: widget.phone, true),
                          onSuccess: (p0) {
                            context.goNamed(ProfilePage.name);
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
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          return VerificationNumber(
                            onChanged: (code) {
                              this.code = code;
                            },
                            onCompleted: (val) {
                              context.read<ProfileBloc>().add(ConfirmEvent(
                                  param: ConfirmParam(otp: val, phone: widget.phone, true),
                                  onSuccess: (p0) {
                                    context.goNamed(ProfilePage.name);
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
