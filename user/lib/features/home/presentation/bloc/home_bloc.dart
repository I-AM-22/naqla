import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/core/util/core_helper_functions.dart';
import 'package:naqla/core/util/secure_image_picker.dart';
import 'package:naqla/features/home/data/model/car_advantage.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/services/location_map_service.dart';

import '../../domain/use_case/get_car_advantage_use_case.dart';
import '../../domain/use_case/get_orders_use_case.dart';
import '../../domain/use_case/upload_photos_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, Map<int, CommonState>> {
  final UploadPhotosUseCase uploadPhotosUseCase;
  final GetCarAdvantageUseCase getCarAdvantageUseCase;
  final GetOrdersUseCase getOrdersUseCase;
  HomeBloc(this.uploadPhotosUseCase, this.getCarAdvantageUseCase, this.getOrdersUseCase) : super(HomeState.iniState) {
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

    on<UploadPhotosEvent>(
      (event, emit) async {
        List<String>? oldData;
        if (state[HomeState.uploadPhotos] is SuccessState) {
          oldData = (state[HomeState.uploadPhotos] as SuccessState).data;
        }
        emit(state.setState(HomeState.uploadPhotos, const LoadingState()));
        final result = await uploadPhotosUseCase(UploadPhotosParam(photos: event.photos));

        result.fold((l) {
          if (oldData != null) {
            emit(state.setState(HomeState.uploadPhotos, SuccessState(oldData)));
          } else {
            emit(state.setState(HomeState.uploadPhotos, ErrorState(l)));
          }
        }, (r) {
          if (oldData != null) {
            oldData.addAll(r);
            emit(state.setState(HomeState.uploadPhotos, SuccessState(oldData)));
          } else {
            emit(state.setState(HomeState.uploadPhotos, SuccessState(r)));
          }
        });
      },
    );

    on<ChangeSelectAdvantageEvent>(
      (event, emit) {
        final List<CarAdvantage> oldData = (state[HomeState.carAdvantage] as SuccessState).data;
        emit(state.setState(
            HomeState.carAdvantage,
            SuccessState<List<CarAdvantage>>(
                oldData.map((element) => element == event.carAdvantage ? element.copyWith(isSelect: !element.isSelect) : element).toList())));
      },
    );

    on<PickPhotosOrder>((event, emit) async {
      final List<File?>? photos = await SecureFilePicker.pickMultiImage(context: event.context);
      if (photos != null) {
        add(UploadPhotosEvent(photos: photos));
      }
    });

    on<GetCarAdvantageEvent>(
      (event, emit) => CoreHelperFunctions.handelMultiApiResult(
          callback: () => getCarAdvantageUseCase(NoParams()), emit: emit, state: state, index: HomeState.carAdvantage),
    );

    on<GetOrdersActiveEvent>(
      (event, emit) => CoreHelperFunctions.handelMultiApiResult(
          callback: () => getOrdersUseCase(NoParams()), emit: emit, state: state, index: HomeState.ordersActive),
    );
  }
}
