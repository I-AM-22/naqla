import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/core/core.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/generated/flutter_gen/assets.gen.dart';
import 'package:user/services/language_service.dart';

class CustomerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomerAppBar({
    super.key,
    required this.appBarParams,
    required this.back,
  });

  final AppBarParams appBarParams;
  final bool back;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: title(context),
          backgroundColor: appBarParams.backgroundColor ??
              Theme.of(context).colorScheme.onPrimary,
          leading: back ? appBarParams.leading ?? leadingAppBar(context) : null,
          actions: appBarParams.action,
          centerTitle: appBarParams.centerTitle,
          elevation: appBarParams.elevation,
          shadowColor: appBarParams.shadowColor,
          surfaceTintColor: appBarParams.surfaceTintColor,
          shape: appBarParams.shape,
        ),
        if (appBarParams.dividerBottom)
          Divider(height: 0, endIndent: 25.w, indent: 25.w)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget title(BuildContext context) {
    return Transform.translate(
      offset: Offset(
          (appBarParams.action?.isNotEmpty ?? true)
              ? 0
              : (LanguageService.rtl ? 30 : -30),
          0),
      child: Row(
        mainAxisAlignment: appBarParams.centerTitle
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (appBarParams.child != null) ...{
            appBarParams.child!,
          },
          if (appBarParams.title != null)
            AppText.headlineMedium(appBarParams.title!,
                style: appBarParams.tittleStyle),
        ],
      ),
    );
  }

  Widget leadingAppBar(BuildContext context) => appBarParams.hasLeading
      ? IconButton(
          icon: AppImage.asset(
            Assets.icons.arrow.rightArrow.path,
            // width: 8.w,
            // height: 15.h,
            color: context.colorScheme.systemGray.shade900,
          ),
          onPressed: appBarParams.onBack ?? () => Navigator.pop(context),
          padding: EdgeInsets.zero,
        )
      : const SizedBox();
}
