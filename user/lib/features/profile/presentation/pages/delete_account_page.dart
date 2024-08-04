import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/domain/repository/prefs_repository.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/auth/presentation/pages/welcome_page.dart';
import 'package:naqla/features/profile/presentation/state/bloc/profile_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../orders/presentation/state/order_bloc.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  static String name = 'DeleteAccountPage';
  static String path = 'DeleteAccountPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileBloc>(),
      child: AppScaffold(
          appBar: AppAppBar(
            appBarParams: AppBarParams(title: S.of(context).delete_account),
            back: true,
          ),
          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: UIConstants.screenPadding30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppText.subHeadRegular(
                  S.of(context).are_you_sure_you_want_to_delete_account,
                  textDirection: context.isArabic ? TextDirection.rtl : TextDirection.ltr,
                  color: context.colorScheme.systemGray.shade600,
                ),
                32.verticalSpace,
                BlocSelector<ProfileBloc, ProfileState, CommonState>(
                  selector: (state) => state.getState(ProfileState.deleteAccount),
                  builder: (context, state) {
                    return AppButton.dark(
                      isLoading: state.isLoading,
                      title: S.of(context).delete_account,
                      onPressed: () {
                        context.read<ProfileBloc>().add(DeleteAccountEvent(
                          () async {
                            await getIt<PrefsRepository>().clearUser();
                            await getIt.resetLazySingleton<HomeBloc>();
                            await getIt.resetLazySingleton<OrderBloc>();
                            await getIt.resetLazySingleton<ProfileBloc>();
                            if (!context.mounted) return;
                            context.goNamed(WelcomePage.name);
                          },
                        ));
                      },
                      stretch: true,
                      style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) => context.colorScheme.error)),
                    );
                  },
                )
              ],
            ),
          )),
    );
  }
}
