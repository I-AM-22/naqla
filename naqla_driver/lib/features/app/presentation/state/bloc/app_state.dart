part of 'app_bloc.dart';

class AppState extends StateObject<AppState> {
  AppState({States? states}) : super([], (states) => AppState(states: states), states);
}
