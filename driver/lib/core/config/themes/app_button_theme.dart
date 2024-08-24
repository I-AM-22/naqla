part of 'app_theme.dart';

extension AppButtonTheme on AppTheme {
  textButtonTheme({required bool isDark}) => TextButtonThemeData(
        style: TextButton.styleFrom(shape: _shape),
      );

  elevatedButtonTheme(ColorScheme scheme) => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: scheme.primary,
            foregroundColor: scheme.surface,
            shape: _shape),
      );

  outlinedButtonTheme({required bool isDark}) => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: _shape,
        ),
      );

  filledButtonTheme({required bool isDark}) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: _shape,
      ),
    );
  }

  get _shape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      );

  double get _borderRadius => 12;
}
