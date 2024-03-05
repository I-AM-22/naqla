import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final PreferredSizeWidget? appBar;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final bool extendBody;

  const AppScaffold({
    super.key,
    required this.body,
    this.extendBody = false,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return GestureDetector(
        onTap: isKeyboardVisible
            ? () => FocusManager.instance.primaryFocus?.unfocus()
            : null,
        child: Scaffold(
          bottomNavigationBar: bottomNavigationBar,
          body: body,
          extendBody: extendBody,
          backgroundColor: backgroundColor,
          appBar: appBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          drawer: drawer,
        ),
      );
    });
  }
}
