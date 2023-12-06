import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:user/core/config/themes/app_theme.dart';
import 'package:user/features/app/presentation/bloc/app_state.dart';

@lazySingleton
class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(AppState(
            lightTheme: ThemeData.light(), darkTheme: ThemeData.dark()));

  changeAppTheme(BuildContext context) {
    emit(state.copyWith(
        lightTheme: AppTheme.light(context),
        darkTheme: AppTheme.dark(context)));
  }
}
