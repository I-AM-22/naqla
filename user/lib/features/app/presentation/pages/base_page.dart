import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key, required this.child});

  final StatefulNavigationShell child;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: child,
      resizeToAvoidBottomInset: false,
    );
  }
}
