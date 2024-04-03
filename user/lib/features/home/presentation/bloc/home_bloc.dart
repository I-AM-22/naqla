import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/exceptions.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/services/location_map_service.dart';

part 'home_event.dart';
part 'home_state.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, Map<int, CommonState>> {
  HomeBloc() : super(HomeState.iniState) {
    on<ChangeLocationEvent>((event, emit) async {
      emit(state.setState(HomeState.changeLocationEvent, const LoadingState()));
      final result = await LocationService().getLocation();
      if (result != null) {
        emit(state.setState(HomeState.changeLocationEvent, SuccessState<LatLng>(LatLng(result.latitude!, result.longitude!))));
        event.onSuccess.call(LatLng(result.latitude!, result.longitude!));
      } else {
        emit(state.setState(
            HomeState.changeLocationEvent, ErrorState(AppException(message: 'Your location cannot be determined', exception: Exception()))));
      }
    });
  }
}
