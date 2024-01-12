import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'app_state.dart';

@lazySingleton
class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(AppState(
            lightTheme: ThemeData.light(), darkTheme: ThemeData.dark()));

  changeAppTheme(BuildContext context) {
    // emit(state.copyWith(
    //     lightTheme: AppTheme.init(context),
    //     darkTheme: AppTheme.dark(context)));
  }
}
