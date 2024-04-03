import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_nav_bar.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/home/presentation/pages/create_order.dart';
import 'package:naqla/generated/flutter_gen/assets.gen.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key, required this.child, required this.fullPath});

  final StatefulNavigationShell child;
  final String fullPath;

  static String get name => "Base";

  static String get path => "/base";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: child,
      resizeToAvoidBottomInset: false,
      floatingActionButton: child.currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: context.colorScheme.primary,
              onPressed: ()=>context.pushNamed(CreateOrderPage.name),
              child: AppImage.asset(
                Assets.icons.essential.home.path,
                color: Colors.white,
              ),
            )
          : null,
      bottomNavigationBar: AppNavigationBar(
          currentIndex: child.currentIndex,
          onTap: (index) {
            child.goBranch(
              index,
              initialLocation: child.currentIndex == index,
            );
          }),
    );
  }
}
