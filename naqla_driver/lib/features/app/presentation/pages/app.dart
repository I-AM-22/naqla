import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/di/di_container.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../core/config/router/router.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../../../../core/config/themes/colors_scheme.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/language_service.dart';
import '../state/bloc/app_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  static ValueNotifier<bool> englishLanguage = ValueNotifier(false);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppBloc bloc = getIt<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: designSize,
      splitScreenMode: true,
      minTextAdapt: false,
      builder: (context, child) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: BlocProvider(
            create: (context) => bloc,
            child: BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                final theme = AppTheme.init(darkColorScheme: darkColorScheme, lightColorScheme: lightColorScheme);
                return ValueListenableBuilder(
                  valueListenable: App.englishLanguage,
                  builder: (context, value, _) => MaterialApp.router(
                    title: 'NaqlaDriver',
                    debugShowCheckedModeBanner: false,
                    theme: theme.lightTheme,
                    routerConfig: GRouter.router,
                    locale: value ? LanguageService.supportedLocales.last : LanguageService.supportedLocales.first,
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: LanguageService.supportedLocales,
                  ),
                );
              },
            )),
      ),
    );
  }
}
