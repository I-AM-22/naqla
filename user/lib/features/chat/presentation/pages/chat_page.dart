import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import 'messages_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  static const String name = 'ChatPage';

  static const String path = '/ChatPage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(appBarParams: AppBarParams(title: S.of(context).chat), back: false),
        body: Padding(
          padding: REdgeInsets.only(left: UIConstants.screenPadding16, right: UIConstants.screenPadding16, top: UIConstants.screenPadding30),
          child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () => context.pushNamed(MessagesPage.name),
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: 8),
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: context.colorScheme.black.withOpacity(.24), offset: const Offset(0, 0), blurRadius: 1)],
                        border: Border.all(color: context.colorScheme.primary),
                        borderRadius: BorderRadius.circular(8),
                        color: context.colorScheme.onPrimary,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25.r,
                            backgroundColor: context.colorScheme.systemGray.shade200,
                          ),
                          8.horizontalSpace,
                          AppText.subHeadMedium(
                            'islam naasani',
                          ),
                          const Spacer(),
                          AppImage.asset(
                            context.isArabic ? Assets.icons.arrow.leftArrow.path : Assets.icons.arrow.rightArrow.path,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
              separatorBuilder: (context, _) => 8.verticalSpace,
              itemCount: 5),
        ));
  }
}
