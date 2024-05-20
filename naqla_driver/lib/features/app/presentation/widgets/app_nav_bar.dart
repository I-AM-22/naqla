import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/app/presentation/widgets/custom_active_icon.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: AppImage.asset(
              Assets.icons.essential.home.path,
              size: 24.h,
            ),
            activeIcon: CustomActiveIcon(
              image: Assets.icons.essential.aHouse.path,
              label: S.of(context).home,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: AppImage.asset(
              Assets.icons.essential.chat.path,
              size: 24.h,
            ),
            activeIcon: CustomActiveIcon(image: Assets.icons.essential.chat.path, label: S.of(context).orders),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: AppImage.asset(
              Assets.icons.essential.profile.path,
              color: context.colorScheme.systemGray.shade300,
              size: 24.h,
            ),
            activeIcon: CustomActiveIcon(
              image: Assets.icons.essential.aUser.path,
              label: S.of(context).profile,
            ),
          ),
        ],
        onTap: onTap,
      ),
    );
  }
}
