import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/custom_active_icon.dart';

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
            icon: Icon(
              IconlyLight.home,
              color: context.colorScheme.primary,
            ),
            activeIcon: CustomActiveIcon(
              iconData: IconlyBold.home,
              label: S.of(context).home,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              IconlyBroken.buy,
              color: context.colorScheme.primary,
            ),
            activeIcon: CustomActiveIcon(iconData: IconlyBold.buy, label: S.of(context).orders),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              IconlyBroken.chat,
              color: context.colorScheme.primary,
            ),
            activeIcon: CustomActiveIcon(
              iconData: IconlyBold.chat,
              label: S.of(context).chat,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              IconlyBroken.profile,
              color: context.colorScheme.primary,
            ),
            activeIcon: CustomActiveIcon(iconData: IconlyBold.profile, label: S.of(context).profile),
          ),
        ],
        onTap: onTap,
      ),
    );
  }
}
