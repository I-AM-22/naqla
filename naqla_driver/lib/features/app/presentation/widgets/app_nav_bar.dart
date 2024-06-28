import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
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
            icon: Icon(
              IconlyBroken.home,
              color: context.colorScheme.primary,
            ),
            activeIcon: CustomActiveIcon(
              icon: IconlyBold.home,
              label: S.of(context).home,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              IconlyBroken.work,
              color: context.colorScheme.primary,
            ),
            activeIcon: CustomActiveIcon(icon: IconlyBold.work, label: S.of(context).orders),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.directions_car_filled_outlined,
              color: context.colorScheme.primary,
            ),
            activeIcon: CustomActiveIcon(icon: Icons.directions_car_filled, label: S.of(context).cars),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              IconlyBroken.chat,
              color: context.colorScheme.primary,
            ),
            activeIcon: CustomActiveIcon(icon: IconlyBold.chat, label: S.of(context).chat),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              IconlyBroken.profile,
              color: context.colorScheme.primary,
            ),
            activeIcon: CustomActiveIcon(
              icon: IconlyBold.profile,
              label: S.of(context).profile,
            ),
          ),
        ],
        onTap: onTap,
      ),
    );
  }
}
