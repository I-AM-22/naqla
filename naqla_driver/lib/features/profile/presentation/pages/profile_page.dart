import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/core/util/core_helper_functions.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/states/app_common_state_builder.dart';
import 'package:naqla_driver/features/auth/data/model/driver_model.dart';
import 'package:naqla_driver/features/profile/presentation/pages/wallet_page.dart';
import 'package:naqla_driver/features/profile/presentation/state/profile_bloc.dart';
import 'package:naqla_driver/features/profile/presentation/widgets/profile_item.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import 'edit_phone_number_page.dart';
import 'edit_profile_page.dart';
import 'language_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String path = "/ProfilePage";
  static String name = "/ProfilePage";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileBloc bloc = getIt<ProfileBloc>();

  @override
  void initState() {
    bloc.add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AppScaffold(
          appBar: AppAppBar(
            back: false,
            appBarParams: AppBarParams(title: S.of(context).profile, action: [
              IconButton(
                  color: context.colorScheme.primary, onPressed: () => CoreHelperFunctions.logOut(context), icon: const Icon(IconlyBroken.logout))
            ]),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              bloc.add(GetProfileEvent());
            },
            child: AppCommonStateBuilder<ProfileBloc, DriverModel>(
              stateName: ProfileState.getProfile,
              onSuccess: (data) => Padding(
                padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: UIConstants.screenPadding30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: 138.w,
                          height: 138.w,
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: context.colorScheme.primary)),
                          child: AppImage.network(data.photo?.mobileUrl ?? ''),
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
                          onTap: () => context.pushNamed(EditProfilePage.name, extra: data),
                          title: S.of(context).edit_profile,
                          prefixIcon: const Icon(IconlyBroken.edit)),
                      16.verticalSpace,
                      ProfileItem(
                          onTap: () => context.pushNamed(EditPhoneNumberPage.name, extra: data.phone),
                          title: S.of(context).edit_phone,
                          prefixIcon: const Icon(IconlyBroken.call)),
                      16.verticalSpace,
                      ProfileItem(
                          onTap: () => context.pushNamed(WalletPage.name, extra: data.wallet),
                          title: S.of(context).wallet,
                          prefixIcon: const Icon(IconlyBroken.wallet)),
                      16.verticalSpace,
                      ProfileItem(
                        onTap: () => context.pushNamed(
                          LanguagePage.name,
                        ),
                        title: S.of(context).language,
                        prefixIcon: AppImage.asset(
                          Assets.icons.essential.website.path,
                          size: 20,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      32.verticalSpace,
                      AppText.subHeadRegular(
                        'Naqla-Driver V1.0.0',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
