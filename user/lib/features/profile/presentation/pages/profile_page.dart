import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/domain/repository/prefs_repository.dart';
import 'package:naqla/features/app/presentation/widgets/animated_dialog.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/drawer_item.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/on_boarding/presentation/pages/on_boarding_screen.dart';
import 'package:naqla/features/profile/presentation/state/bloc/profile_bloc.dart';
import 'package:naqla/features/profile/presentation/widget/profile_item.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static String get path => '/ProfilePage';

  static String get name => '/ProfilePage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileBloc>()..add(GetPersonalInfoEvent()),
      child: AppScaffold(
          drawer: ClipRRect(
            borderRadius: context.isArabic
                ? const BorderRadius.only(
                    topLeft: Radius.circular(80),
                    bottomLeft: Radius.circular(80))
                : const BorderRadius.only(
                    topRight: Radius.circular(80),
                    bottomRight: Radius.circular(80)),
            child: Drawer(
              backgroundColor: context.colorScheme.onPrimary,
              child: ListView(
                padding: REdgeInsets.symmetric(
                    horizontal: UIConstants.screenPadding16,
                    vertical: UIConstants.screenPadding30),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppImage.asset(context.isArabic
                          ? Assets.icons.arrow.rightArrow.path
                          : Assets.icons.arrow.leftArrow.path),
                      AppText.subHeadMedium(S.of(context).back),
                    ],
                  ),
                  27.verticalSpace,
                  const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CircleAvatar(
                      radius: 50,
                    ),
                  ),
                  18.verticalSpace,
                  AppText.headlineSmall('majed'),
                  AppText.bodySmall('majed@gmail.com'),
                  40.verticalSpace,
                  DrawerItem(
                      icon: Assets.icons.essential.profile.path,
                      title: S.of(context).edit_profile),
                  DrawerItem(
                      icon: Assets.icons.essential.info.path,
                      title: S.of(context).about_us),
                  DrawerItem(
                      icon: Assets.icons.essential.info.path,
                      title: S.of(context).help_and_support),
                  DrawerItem(
                    icon: Assets.icons.essential.website.path,
                    title: S.of(context).language,
                    showDropDown: true,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  DrawerItem(
                    icon: Assets.icons.essential.logout.path,
                    title: S.of(context).logOut,
                    lastItem: true,
                    onTap: () {
                      context.pop();
                      logOut(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          appBar: AppAppBar(
            appBarParams: AppBarParams(
              title: S.of(context).profile,
              leading: Builder(builder: (context) {
                return Padding(
                  padding: REdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
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
                  ),
                );
              }),
            ),
            back: true,
          ),
          body: AppCommonStateBuilder<ProfileBloc, User>(
            index: ProfileState.getPersonalInfo,
            onSuccess: (data) => Padding(
              padding: REdgeInsets.symmetric(
                  vertical: UIConstants.screenPadding30,
                  horizontal: UIConstants.screenPadding16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: 138.w,
                        height: 138.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: context.colorScheme.primary)),
                        child: BlurHash(
                            imageFit: BoxFit.cover,
                            hash: data.photo.blurHash,
                            image: data.photo.profileUrl),
                      ),
                    ),
                    24.verticalSpace,
                    Center(
                      child: AppText.subHeadMedium(
                        '${data.firstName}  ${data.lastName}, ${data.phone}',
                        color: context.colorScheme.systemGray.shade700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    24.verticalSpace,
                    ProfileItem(
                        onTap: () => context.pushNamed(EditProfilePage.name,
                            extra: data),
                        title: S.of(context).edit_profile,
                        prefixIcon: Assets.icons.essential.profile.path),
                    16.verticalSpace,
                    ProfileItem(
                        title: S.of(context).edit_phone,
                        prefixIcon: Assets.icons.essential.mobile.path),
                    16.verticalSpace,
                    ProfileItem(
                        title: S.of(context).about_us,
                        prefixIcon: Assets.icons.essential.circleQuistion.path),
                    16.verticalSpace,
                    ProfileItem(
                        title: S.of(context).help_and_support,
                        prefixIcon: Assets.icons.essential.info.path),
                    16.verticalSpace,
                    ProfileItem(
                        onTap: () => logOut(context),
                        title: S.of(context).logOut,
                        prefixIcon: Assets.icons.essential.logout.path),
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

  void logOut(BuildContext context) => AnimatedDialog.show(context,
      child: Padding(
        padding: REdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.titleSmall(S.of(context).logOut),
            4.verticalSpace,
            AppText.bodyMedium(S.of(context).are_you_sure_you_want_to_log_out),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppButton.ghost(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => context.colorScheme.error)),
                    buttonSize: ButtonSize.medium,
                    child: AppText.bodySmall(
                      S.of(context).logOut,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await getIt<PrefsRepository>().clearUser();
                      if (!context.mounted) return;
                      context.goNamed(OnBoardingScreen.name);
                    }),
                AppButton.ghost(
                  buttonSize: ButtonSize.medium,
                  child: AppText.bodySmall(S.of(context).cancel),
                  onPressed: () {
                    context.pop(S.of(context).cancel);
                  },
                )
              ],
            )
          ],
        ),
      ));
}
