import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/config/router/router.dart';
import 'package:naqla/features/app/presentation/bloc/app_bloc.dart';
import 'package:naqla/features/app/presentation/bloc/app_state.dart';
import 'package:naqla/services/language_service.dart';
import 'package:naqla/core/core.dart';

import '../../../../generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

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
        child: BlocProvider.value(
            value: GetIt.I<AppCubit>(),
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                final theme = AppTheme.init(
                    darkColorScheme: darkColorScheme,
                    lightColorScheme: lightColorScheme);
                return MaterialApp.router(
                  title: 'NaqlaCustomer',
                  debugShowCheckedModeBanner: false,
                  theme: theme.lightTheme,
                  routerConfig: GRouter.router,
                  locale: LanguageService.supportedLocales.first,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: LanguageService.supportedLocales,
                );
              },
            )),
      ),
    );
  }
}
