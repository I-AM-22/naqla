import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla_driver/services/language_service.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    required this.appBarParams,
    this.back = true,
  });

  final AppBarParams appBarParams;
  final bool back;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: title(context),
          backgroundColor: appBarParams.backgroundColor ?? Theme.of(context).colorScheme.onPrimary,
          leading: back ? appBarParams.leading ?? leadingAppBar(context) : null,
          actions: appBarParams.action,
          centerTitle: appBarParams.centerTitle,
          elevation: appBarParams.elevation,
          shadowColor: appBarParams.shadowColor,
          surfaceTintColor: appBarParams.surfaceTintColor,
          shape: appBarParams.shape,
        ),
        if (appBarParams.dividerBottom) Divider(height: 0, endIndent: 25.w, indent: 25.w)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget title(BuildContext context) {
    return Transform.translate(
      offset: Offset((appBarParams.action?.isNotEmpty ?? true) ? 0 : (LanguageService.rtl ? 30 : -30), 0),
      child: Row(
        mainAxisAlignment: appBarParams.centerTitle ? MainAxisAlignment.center : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (appBarParams.child != null) ...{
            appBarParams.child!,
          },
          if (appBarParams.title != null) AppText.headlineMedium(appBarParams.title!, style: appBarParams.tittleStyle),
        ],
      ),
    );
  }

  Widget leadingAppBar(BuildContext context) => appBarParams.hasLeading
      ? IconButton(
          icon: AppImage.asset(
            context.locale == const Locale('en', 'US') ? Assets.icons.arrow.leftArrow.path : Assets.icons.arrow.rightArrow.path,
            // width: 8.w,
            // height: 15.h,
            color: context.colorScheme.systemGray.shade900,
          ),
          onPressed: appBarParams.onBack ?? () => Navigator.pop(context),
          padding: EdgeInsets.zero,
        )
      : const SizedBox();
}
