import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/core/config/themes/my_color_scheme.dart';
import 'package:user/core/util/extensions/build_context.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/services/language_service.dart';

import 'app_text_view.dart';

class DriverAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DriverAppBar({
    Key? key,
    required this.appBarParams,
    required this.isLeading,
  }) : super(key: key);

  final AppBarParams appBarParams;
  final bool isLeading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: title(context),
          backgroundColor: appBarParams.backgroundColor ??
              Theme.of(context).colorScheme.primary,
          leading:
              isLeading ? appBarParams.leading ?? leadingAppBar(context) : null,
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
            AppTextView(
              appBarParams.title!,
              style: appBarParams.tittleStyle ??
                  Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: appBarParams.textColor,
                      ),
            ),
        ],
      ),
    );
  }

  Widget leadingAppBar(BuildContext context) => appBarParams.hasLeading
      ? IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: context.colorScheme.white,
            size: 18,
          ),
          onPressed: appBarParams.onBack ?? () => Navigator.pop(context),
          padding: EdgeInsets.zero,
        )
      : const SizedBox();
}
