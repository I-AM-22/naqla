import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/model/page_state/page_state.dart';

part 'home_event.dart';
part 'home_state.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeState(
            mapController: Completer(),
            polylineState: const PageState.init())) {
    on<SetCurrentLocation>(_onSetCurrentLocation);
  }

  _onSetCurrentLocation(
      SetCurrentLocation event, Emitter<HomeState> emit) async {
    //? In case The route has not been shown for the new location or the location has changed
    if ((event.location.longitude != state.currentLocation?.longitude ||
            event.location.latitude != state.currentLocation?.latitude) &&
        state.lastOrderNumber != null) {
      emit(state.copyWith(currentLocation: event.location));
    } else {
      emit(state.copyWith(currentLocation: event.location));
    }
  }
}
