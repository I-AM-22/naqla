import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/core/util/core_helper_functions.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/profile/presentation/pages/edit_phone_number_page.dart';
import 'package:naqla/features/profile/presentation/state/bloc/profile_bloc.dart';
import 'package:naqla/features/profile/presentation/widget/profile_item.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/data/model/user_model.dart';
import 'about_us_page.dart';
import 'delete_account_page.dart';
import 'edit_profile_page.dart';
import 'help_and_support_page.dart';
import 'language_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static String get path => '/ProfilePage';

  static String get name => '/ProfilePage';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final bloc = getIt<ProfileBloc>();

  @override
  void initState() {
    bloc.add(GetPersonalInfoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(
              title: S.of(context).profile,
            ),
            back: false,
          ),
          body: AppCommonStateBuilder<ProfileBloc, User>(
            stateName: ProfileState.getPersonalInfo,
            onSuccess: (data) => Padding(
              padding: REdgeInsets.symmetric(vertical: UIConstants.screenPadding30, horizontal: UIConstants.screenPadding16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: 138.w,
                        height: 138.w,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: context.colorScheme.primary)),
                        child: BlurHash(imageFit: BoxFit.cover, hash: data.photo.blurHash, image: data.photo.profileUrl),
                      ),
                    ),
                    24.verticalSpace,
                    Center(
                      child: AppText.subHeadMedium(
                        '${data.firstName} ${data.lastName}, ${data.phone}',
                        color: context.colorScheme.systemGray.shade700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    24.verticalSpace,
                    ProfileItem(
                        onTap: () => context.pushNamed(EditProfilePage.name, extra: EditProfileParam(bloc: bloc, user: data)),
                        title: S.of(context).edit_profile,
                        prefixIcon: Assets.icons.essential.profile.path),
                    16.verticalSpace,
                    ProfileItem(
                        onTap: () => context.pushNamed(EditPhoneNumberPage.name, extra: EditPhoneParam(bloc: bloc, phone: data.phone)),
                        title: S.of(context).edit_phone,
                        prefixIcon: Assets.icons.essential.mobile.path),
                    16.verticalSpace,
                    ProfileItem(
                      onTap: () => context.pushNamed(
                        LanguagePage.name,
                      ),
                      title: S.of(context).language,
                      prefixIcon: Assets.icons.essential.website.path,
                    ),
                    16.verticalSpace,
                    ProfileItem(
                        title: S.of(context).about_us,
                        onTap: () => context.pushNamed(AboutUsPage.name),
                        prefixIcon: Assets.icons.essential.circleQuistion.path),
                    16.verticalSpace,
                    ProfileItem(
                      title: S.of(context).help_and_support,
                      prefixIcon: Assets.icons.essential.info.path,
                      onTap: () => context.pushNamed(HelpAndSupportPage.name),
                    ),
                    16.verticalSpace,
                    ProfileItem(
                        onTap: () => CoreHelperFunctions.logOut(context),
                        title: S.of(context).logOut,
                        prefixIcon: Assets.icons.essential.logout.path),
                    16.verticalSpace,
                    ProfileItem(
                        onTap: () => context.pushNamed(DeleteAccountPage.name),
                        title: S.of(context).delete_account,
                        prefixIcon: Assets.icons.essential.delete.path),
                    32.verticalSpace,
                    AppText.subHeadRegular(
                      'Naqla V1.0.0',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
