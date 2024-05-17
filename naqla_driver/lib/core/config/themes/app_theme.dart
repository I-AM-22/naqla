import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';

part 'general_theme.dart';
part 'typography.dart';
part 'app_button_theme.dart';

class AppTheme {
  AppTheme.init({
    required this.darkColorScheme,
    required this.lightColorScheme,
  });

  final ColorScheme darkColorScheme;
  final ColorScheme lightColorScheme;

  AppBarTheme appBarTheme(ColorScheme scheme) => AppBarTheme(
      backgroundColor: scheme.onPrimary,
      toolbarHeight: 48,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarDividerColor: scheme.surface,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: scheme.surface,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
      elevation: 0,
      foregroundColor: scheme.onPrimary,
      centerTitle: true,
      iconTheme: IconThemeData(size: 24.r, color: scheme.onPrimary));

  ///CheckBox
  CheckboxThemeData checkboxThemeData({required bool isDark}) => const CheckboxThemeData(
      // fillColor: MaterialStateProperty.all(
      //     isDark ? darkColorScheme.primary : lightColorScheme.primary),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(PRadius.checkBox.r),
      // ),
      );

  /// Icon
  IconThemeData iconTheme(ColorScheme scheme) => IconThemeData(
        size: 20.r,
        color: scheme.primary,
      );

  ///Chip
  ChipThemeData chipTheme({required bool isDark}) => const ChipThemeData(
      // padding: ,
      // selectedColor:
      //     isDark ? darkColorScheme.secondary : lightColorScheme.secondary,
      // backgroundColor: Colors.transparent,
      // shape: RoundedRectangleBorder(
      //   side: BorderSide(width: 1.r),
      //   borderRadius: BorderRadius.circular(PRadius.chip.r),
      // ),
      );

  ///FloatingActionButtonThemeData
  FloatingActionButtonThemeData floatingActionButtonTheme({required bool isDark}) => const FloatingActionButtonThemeData(
      // backgroundColor:
      //     isDark ? darkColorScheme.background : lightColorScheme.background,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(PRadius.floatingButton.r),
      // ),
      );

  ///TabBarTheme
  TabBarTheme tabBarTheme(ColorScheme scheme) => TabBarTheme(
        labelColor: scheme.secondary,
        unselectedLabelColor: scheme.onSecondary,
      );

  ///bottomSheetTheme
  bottomSheetTheme({required bool isDark}) => const BottomSheetThemeData(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(PRadius.container),
      //     topRight: Radius.circular(PRadius.container),
      //   ),
      // ),
      );

  ///cardTheme
  CardTheme cardTheme(ColorScheme scheme) => CardTheme(
        color: scheme.surface, elevation: 0,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(8.r),
        // ),
      );

  ///dialogTheme
  DialogTheme dialogTheme({required bool isDark}) => const DialogTheme(

      //     shape: RoundedRectangleBorder(
      //         // borderRadius: PBorderRadius.borderRadiusAllM2
      // )
      );

  ///listTileTheme
  ListTileThemeData listTileTheme({required bool isDark}) => const ListTileThemeData(
      // horizontalTitleGap: 0,
      // contentPadding: PEdgeInsets.allS3,
      );

  DividerThemeData dividerTheme(ColorScheme scheme) => DividerThemeData(color: scheme.outline, endIndent: 0, indent: 0, thickness: 1.r, space: 20.r);

  ///navigationBarTheme
  NavigationBarThemeData navigationBarTheme({required bool isDark}) => const NavigationBarThemeData(
      // backgroundColor:
      // labelTextStyle: MaterialStateProperty.resolveWith((states) {
      //   if (states.contains(MaterialState.selected)) {
      //     return  isDark ? AppFont.darkTextTheme.labelSmall?.copyWith(
      //       color: darkColorScheme.primary,
      //     ) : AppFont.lightTextTheme.labelSmall?.copyWith(
      //       color: Colors.red,
      //     );
      //   }
      //   return isDark ? AppFont.darkTextTheme.labelSmall?.copyWith(
      //     color: darkColorScheme.onSurfaceVariant,
      //   ) : AppFont.lightTextTheme.labelSmall?.copyWith(
      //     color: Colors.red,
      //   );
      // }),
      // elevation: 5,
      // shadowColor: isDark ? darkColorScheme.shadow : lightColorScheme.shadow,
      // labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      // indicatorColor: Colors.transparent,
      // iconTheme: MaterialStateProperty.resolveWith((states) {
      //   if (states.contains(MaterialState.selected)) {
      //     return IconThemeData(
      //         color: isDark
      //             ? darkColorScheme.onInverseSurface
      //             : lightColorScheme.onInverseSurface);
      //   }
      //   return IconThemeData(
      //       color: isDark
      //           ? darkColorScheme.inverseSurface.withOpacity(0.5)
      //           : lightColorScheme.inverseSurface.withOpacity(0.5));
      // }),
      // backgroundColor:
      //     isDark ? darkColorScheme.background : lightColorScheme.background,
      // height: 50.h,
      );

  BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme scheme) => BottomNavigationBarThemeData(
        // backgroundColor:
        //     isDark ? darkColorScheme.background : lightColorScheme.background,
        selectedItemColor: scheme.primary,
        unselectedItemColor: scheme.secondary,

        ///todo change bodyMedium to the size used in app
        selectedLabelStyle: textTheme.bodyMedium?.copyWith(color: scheme.primary),
        unselectedIconTheme: IconThemeData(size: 25, color: scheme.secondary),
        selectedIconTheme: IconThemeData(size: 25, color: scheme.primary),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 0,
        backgroundColor: scheme.surface,
      );

  InputDecorationTheme inputDecoration({required bool isDark}) {
    ///todo add border color
    /////todo make width border responsive v
    const inputBorderRadius = BorderRadius.all(Radius.circular(12.0));
    return const InputDecorationTheme(
      contentPadding: EdgeInsets.all(16),

      ///contentPadding will be set in the widget because is different in every state
      // prefixStyle: isDark
      //     ? AppFont.darkTextTheme.titleMedium
      //         ?.copyWith(color: darkColorScheme.onSurface)
      //     : AppFont.lightTextTheme.titleMedium
      //         ?.copyWith(color: lightColorScheme.onSurface),
      // fillColor: isDark
      //     ? darkColorScheme.surfaceVariant
      //     : lightColorScheme.surfaceVariant,
      //todo check this  in multi line
      constraints: BoxConstraints(maxHeight: 56, minHeight: 56),
      // filled: true,
      // labelStyle: isDark
      //     ? AppFont.darkTextTheme.bodyLarge
      //         ?.copyWith(color: darkColorScheme.onSurfaceVariant)
      //     : AppFont.lightTextTheme.bodyLarge
      //         ?.copyWith(color: lightColorScheme.onSurfaceVariant),
      // hintStyle: isDark
      //     ? AppFont.darkTextTheme.bodyLarge
      //         ?.copyWith(color: darkColorScheme.onSurfaceVariant)
      //     : AppFont.lightTextTheme.bodyLarge
      //         ?.copyWith(color: lightColorScheme.onSurfaceVariant),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1),
        borderRadius: inputBorderRadius,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 1),
        borderRadius: inputBorderRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2),
        borderRadius: inputBorderRadius,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1),
        borderRadius: inputBorderRadius,
      ),
      // disabledBorder: OutlineInputBorder(
      //   borderSide: BorderSide.none,
      //   borderRadius: _inputBorderRadius,
      // ),
    );
  }
}
