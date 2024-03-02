part of 'profile_bloc.dart';

class ProfileState {
  static int getPersonalInfo = 0;

  static Map<int, CommonState> get iniState =>
      {getPersonalInfo: const InitialState<User>()};
}
