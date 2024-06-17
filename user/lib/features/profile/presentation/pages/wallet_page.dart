import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/auth/data/model/wallet_model.dart';

import '../../../../generated/l10n.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key, required this.wallet});
  final Wallet wallet;

  static String path = 'WalletPage';
  static String name = 'WalletPage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(title: S.of(context).wallet),
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20),
          child: Container(
            width: double.infinity,
            padding: REdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colorScheme.outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.subHeadMedium('${S.of(context).total_money} ${wallet.total} ${S.of(context).syp}'),
                16.verticalSpace,
                AppText.subHeadMedium('${S.of(context).available_money} ${wallet.available} ${S.of(context).syp}'),
                16.verticalSpace,
                AppText.subHeadMedium('${S.of(context).pending_money} ${wallet.pending} ${S.of(context).syp}')
              ],
            ),
          ),
        ));
  }
}
