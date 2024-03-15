import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../app/presentation/widgets/app_scaffold.dart';
import '../../../app/presentation/widgets/customer_appbar.dart';
import '../../../app/presentation/widgets/params_appbar.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  static const String name = 'MessagesPage';
  static const String path = 'MessagesPage';

  @override
  Widget build(BuildContext context) {
    final receive = [
      'Good Evening!',
      'Welcome to Car2go Customer Service',
      'Welcome to Car2go Customer Service',
      'Welcome to Car2go Customer Service',
      'Welcome to Car2go Customer Service',
      'Welcome to Car2go Customer Service',
      'Welcome to Car2go Customer Service',
      'Welcome to Car2go Customer Service',
      'Welcome to Car2go Customer Service',
      'Welcome to Car2go Customer Service'
    ];

    return AppScaffold(
        appBar: AppAppBar(
            appBarParams: AppBarParams(
          title: 'islam',
        )),
        body: Padding(
          padding: REdgeInsets.only(left: UIConstants.screenPadding16, right: UIConstants.screenPadding16, top: UIConstants.screenPadding30),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => Column(
                          crossAxisAlignment: index % 2 == 0 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: REdgeInsets.only(bottom: 8),
                              padding: REdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: index % 2 == 0 ? context.colorScheme.systemGray.shade100 : context.colorScheme.primary50,
                                  borderRadius: BorderRadius.only(
                                      topRight: index % 2 == 0 ? const Radius.circular(16) : Radius.zero,
                                      topLeft: index % 2 != 0 ? const Radius.circular(16) : Radius.zero,
                                      bottomLeft: const Radius.circular(16),
                                      bottomRight: const Radius.circular(16)),
                                  border: index % 2 == 0 ? null : Border.all(color: context.colorScheme.primary)),
                              child: AppText.bodyRegular(
                                receive[index],
                                style: TextStyle(fontSize: 14.sp),
                                color: index % 2 == 0 ? context.colorScheme.tertiary : context.colorScheme.systemGray.shade700,
                              ),
                            ),
                            AppText.bodyRegular(
                              '8:29 pm',
                              style: TextStyle(fontSize: 12.sp),
                              color: context.colorScheme.tertiary,
                            ),
                          ],
                        ),
                    separatorBuilder: (context, _) => 8.verticalSpace,
                    itemCount: receive.length),
              ),
              // Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: AppImage.asset(
                        Assets.icons.essential.sendIcon.path,
                        size: 20.w,
                      ),
                    ),
                    Expanded(
                      child: AppTextFormField(
                        hintText: S.of(context).write_message,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: context.colorScheme.systemGray.shade300),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                fixedSize: Size(20.w, 20.w),
                              ),
                              icon: AppImage.asset(Assets.icons.essential.emoje.path, size: 20.w),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
