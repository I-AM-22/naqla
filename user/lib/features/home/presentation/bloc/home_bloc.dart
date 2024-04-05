import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/util/core_helper_functions.dart';
import 'package:naqla/core/util/secure_image_picker.dart';
import 'package:naqla/services/location_map_service.dart';

import '../../domain/use_case/upload_photos_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, Map<int, CommonState>> {
  final UploadPhotosUseCase uploadPhotosUseCase;
  HomeBloc(this.uploadPhotosUseCase) : super(HomeState.iniState) {
    on<ChangeLocationEvent>((event, emit) {
      return CoreHelperFunctions.handelMultiApiResult(
        callback: () async => LocationService().getLocation(),
        emit: emit,
        state: state,
        index: HomeState.changeLocationEvent,
        onSuccess: (p0) {
          event.onSuccess.call(LatLng((p0 as LocationData).latitude!, (p0).longitude!));
        },
      );
    });

    on<UploadPhotosEvent>((event, emit) => CoreHelperFunctions.handelMultiApiResult(
        callback: () => uploadPhotosUseCase(UploadPhotosParam(photos: event.photos)), emit: emit, state: state, index: HomeState.uploadPhotos));

    on<PickPhotosOrder>((event, emit) async {
      final List<File?>? photos = await SecureFilePicker.pickMultiImage(context: event.context);
      if (photos != null) {
        add(UploadPhotosEvent(photos: photos));
      }
    });
  }
}
