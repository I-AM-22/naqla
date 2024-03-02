import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/profile/presentation/state/bloc/profile_bloc.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static String get path => '/ProfilePage';

  static String get name => '/ProfilePage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileBloc>()..add(GetPersonalInfoEvent()),
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(
              title: 'Edit Profile',
              action: [
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                      width: 34.w,
                      height: 34.w,
                      decoration: BoxDecoration(
                          color: const Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: AppImage.asset(
                          Assets.icons.essential.moreIcon.path,
                          size: 15.r,
                        ),
                      )),
                )
              ],
            ),
            back: false,
          ),
          body: AppCommonStateBuilder<ProfileBloc, User>(
            index: ProfileState.getPersonalInfo,
            onSuccess: (data) => Padding(
              padding: REdgeInsets.symmetric(
                  vertical: UIConstants.screenPadding30,
                  horizontal: UIConstants.screenPadding16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 138.w,
                          height: 138.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(data.photo.profileUrl)),
                              border: Border.all(
                                  color: context.colorScheme.primary)),
                        ),
                        Container(
                          margin: REdgeInsets.only(right: 10),
                          width: 25.h,
                          height: 25.h,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              border: Border.all(
                                  color: context.colorScheme.primary),
                              shape: BoxShape.circle),
                          child: Center(
                            child: AppImage.asset(
                              Assets.icons.essential.edit.path,
                              size: 15.r,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  24.verticalSpace,
                  Center(
                    child: AppText.titleMedium(
                      data.firstName + data.lastName,
                      color: context.colorScheme.systemGray.shade700,
                    ),
                  ),
                  24.verticalSpace,
                  AppTextFormField(
                    initialValue: data.phone,
                    hintText: 'nate@email.con',
                  ),
                  16.verticalSpace,
                  AppTextFormField(
                    name: 'phoneNumber',
                    initialValue: data.phone,
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
                  32.verticalSpace,
                  AppButton.dark(
                    stretch: true,
                    title: 'update',
                    onPressed: () {},
                  )
                ],
              ),
            ),
          )),
    );
  }
}
