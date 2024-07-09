import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/orders/presentation/widgets/rate_widget.dart';

import '../../../../generated/l10n.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  static String path = "RatingPage";

  static String name = "RatingPage";

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  ValueNotifier<int> rateServicesNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(title: S.of(context).rate_the_driver),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.symmetric(
                horizontal: UIConstants.screenPadding20,
                vertical: UIConstants.screenPadding30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RateWidget(
                  ratingNotifier: rateServicesNotifier,
                ),
                16.verticalSpace,
                AppTextFormField(
                  name: 'reason',
                  textInputAction: TextInputAction.newline,
                  hintText: S.of(context).write_a_comment_note,
                  minLines: 5,
                  maxLines: 10,
                ),
                16.verticalSpace,
                AppButton.dark(
                  title: S.of(context).Save,
                  stretch: true,
                  onPressed: () {
                    showMessage('بهاء مااشتغلها');
                  },
                )
              ],
            ),
          ),
        ));
  }
}
