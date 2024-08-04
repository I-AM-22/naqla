import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla_driver/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/features/auth/data/model/wallet_model.dart';

import '../../../../generated/l10n.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key, required this.walletModel});
  final WalletModel walletModel;

  static String path = "walletPage";
  static String name = "walletPage";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(title: S.of(context).wallet),
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding20, vertical: UIConstants.screenPadding30),
          child: Container(
            padding: REdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              boxShadow: [BoxShadow(color: context.colorScheme.outline, offset: const Offset(0, 1), blurRadius: 2)],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.subHeadMedium('${S.of(context).total_money} ${formatter.format(walletModel.total)} ${S.of(context).syp}'),
                10.verticalSpace,
                AppText.subHeadMedium('${S.of(context).available_money} ${formatter.format(walletModel.available)} ${S.of(context).syp}'),
                if (walletModel.pending != 0) ...{
                  10.verticalSpace,
                  AppText.subHeadMedium('${S.of(context).pending_money} ${formatter.format(walletModel.pending)} ${S.of(context).syp}'),
                }
              ],
            ),
          ),
        ));
  }
}
