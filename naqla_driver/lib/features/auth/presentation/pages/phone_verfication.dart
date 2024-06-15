import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/auth/presentation/state/auth_bloc.dart';
import 'package:naqla_driver/features/home/presentation/pages/home_page.dart';
import '../../../../core/common/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/app_scaffold.dart';
import '../widget/verification_number.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  static String get name => 'PhoneVerificationPage';

  static String get path => 'PhoneVerificationPage';

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final GlobalKey<FormBuilderState> _key = GlobalKey();
  String code = '';
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        backgroundColor: const Color(0xff222636),
        body: Container(
          margin: REdgeInsets.only(top: 100),
          padding: REdgeInsets.symmetric(
            horizontal: UIConstants.screenPadding30,
            vertical: 50.h,
          ),
          height: context.fullHeight,
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
              AppText.titleMedium(
                S.of(context).phone_verification,
                textAlign: TextAlign.center,
              ),
              12.verticalSpace,
              RichText(
                text: TextSpan(
                  style: TextStyle(color: context.colorScheme.systemGray, fontSize: 16.sp),
                  children: [TextSpan(text: S.of(context).enter_code), TextSpan(text: S.of(context).otp), TextSpan(text: S.of(context).your_code)],
                ),
              ),
              40.verticalSpace,
              FormBuilder(
                key: _key,
                child: VerificationNumber(
                  onChanged: (code) {
                    this.code = code;
                  },
                  onCompleted: (val) {
                    context.read<AuthBloc>().add(ConfirmEvent(
                          otp: code,
                          onSuccess: () {
                            context.goNamed(HomePage.name);
                          },
                        ));
                  },
                ),
              ),
              32.verticalSpace,
              BlocSelector<AuthBloc, AuthState, CommonState>(
                selector: (state) => state.getState(AuthState.confirm),
                builder: (context, state) {
                  return AppButton.dark(
                    isLoading: state.isLoading,
                    onPressed: () {
                      _key.currentState?.save();
                      _key.currentState?.validate();
                      if (code.isNotEmpty && code.length > 5) {
                        context.read<AuthBloc>().add(ConfirmEvent(
                              otp: code,
                              onSuccess: () {
                                context.goNamed(HomePage.name);
                              },
                            ));
                      }
                    },
                    stretch: true,
                    title: S.of(context).verify,
                    fixedSize: Size.fromHeight(48.h),
                  );
                },
              ),
              // const Spacer(),
            ],
          ),
        ));
  }
}
