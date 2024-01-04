import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/core/common/constants/constants.dart';
import 'package:user/core/config/router/router.dart';
import 'package:user/features/app/presentation/bloc/app_bloc.dart';
import 'package:user/features/app/presentation/bloc/app_state.dart';
import 'package:user/services/language_service.dart';
import 'package:user/services/service_provider.dart';
import 'package:user/core/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: designSize,
      builder: (context, child) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: ServiceProvider(child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final theme = AppTheme.init(
                darkColorScheme: darkColorScheme,
                lightColorScheme: lightColorScheme);
            LanguageService(context);
            return MaterialApp.router(
              title: 'Driver',
              debugShowCheckedModeBanner: false,
              theme: theme.lightTheme,
              //darkTheme: AppTheme.dark(context),
              routerConfig: GRouter.router,
              locale: context.locale,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
            );
          },
        )),
      ),
    );
  }
}
