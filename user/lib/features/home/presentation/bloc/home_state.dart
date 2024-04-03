part of 'home_bloc.dart';

class HomeState {
  static int changeLocationEvent = 0;

  static Map<int, CommonState> get iniState => {
        changeLocationEvent: const InitialState<LatLng>(),
      };
}
