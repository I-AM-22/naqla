import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/profile/presentation/pages/profile_page.dart';
import 'package:naqla_driver/features/profile/presentation/state/profile_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/app_scaffold.dart';
import '../../../auth/presentation/widget/verification_number.dart';

class VerificationUpdatePhoneNumber extends StatefulWidget {
  const VerificationUpdatePhoneNumber({super.key});

  static String get name => 'VerificationUpdatePhoneNumber';

  static String get path => 'VerificationUpdatePhoneNumber';

  @override
  State<VerificationUpdatePhoneNumber> createState() => _VerificationUpdatePhoneNumberState();
}

class _VerificationUpdatePhoneNumberState extends State<VerificationUpdatePhoneNumber> {
  final GlobalKey<FormBuilderState> _key = GlobalKey();
  final ProfileBloc bloc = getIt<ProfileBloc>();
  String code = '';
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(),
          ),
          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: UIConstants.screenPadding30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppText.titleMedium(
                  S.of(context).phone_verification,
                  textAlign: TextAlign.center,
                ),
                12.verticalSpace,
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: context.colorScheme.systemGray, fontSize: 16.sp),
                      children: [
                        TextSpan(text: S.of(context).enter_code),
                        TextSpan(text: S.of(context).otp),
                        TextSpan(text: S.of(context).your_code)
                      ],
                    ),
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
                      bloc.add(ConfirmEvent(
                        otp: code,
                        onSuccess: () {
                          context.goNamed(ProfilePage.name);
                        },
                      ));
                    },
                  ),
                ),
                32.verticalSpace,
                BlocSelector<ProfileBloc, ProfileState, CommonState>(
                  selector: (state) => state.getState(ProfileState.confirm),
                  builder: (context, state) {
                    return AppButton.dark(
                      isLoading: state.isLoading,
                      onPressed: () {
                        _key.currentState?.save();
                        _key.currentState?.validate();
                        if (code.isNotEmpty && code.length > 5) {
                          bloc.add(ConfirmEvent(
                            otp: code,
                            onSuccess: () {
                              context.goNamed(ProfilePage.name);
                            },
                          ));
                        }
                      },
                      stretch: true,
                      title: S.of(context).verify,
                    );
                  },
                ),
                // const Spacer(),
              ],
            ),
          )),
    );
  }
}
