import 'dart:io';

import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:naqla/core/use_case/use_case.dart';
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
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UploadPhotosUseCase uploadPhotosUseCase;
  final GetCarAdvantageUseCase getCarAdvantageUseCase;
  final GetOrdersUseCase getOrdersUseCase;
  HomeBloc(this.uploadPhotosUseCase, this.getCarAdvantageUseCase, this.getOrdersUseCase) : super(HomeState()) {
    multiStateApiCall<ChangeLocationEvent, LocationData?>(
      HomeState.changeLocationEvent,
      (event) => LocationService().getLocation(),
      onSuccess: (data, event, emit) => event.onSuccess(LatLng(data?.latitude ?? 0, data?.longitude ?? 0)),
    );

    multiStateApiCall<GetCarAdvantageEvent, List<CarAdvantage>>(HomeState.carAdvantage, (event) => getCarAdvantageUseCase(NoParams()));

    multiStateApiCall<GetOrdersActiveEvent, List<OrderModel>>(HomeState.ordersActive, (event) => getOrdersUseCase(NoParams()));

    on<UploadPhotosEvent>(
      (event, emit) async {
        List<String>? oldData;
        if (state.getState(HomeState.uploadPhotos).isSuccess) {
          oldData = state.getState(HomeState.uploadPhotos).data;
        }
        emit(state.updateState(HomeState.uploadPhotos, const LoadingState()));
        final result = await uploadPhotosUseCase(UploadPhotosParam(photos: event.photos));

        result.fold((l) {
          if (oldData != null) {
            emit(state.updateState(HomeState.uploadPhotos, SuccessState(oldData)));
          } else {
            emit(state.updateState(HomeState.uploadPhotos, FailureState(l)));
          }
        }, (r) {
          if (oldData != null) {
            oldData.addAll(r);
            emit(state.updateState(HomeState.uploadPhotos, SuccessState(oldData)));
          } else {
            emit(state.updateState(HomeState.uploadPhotos, SuccessState(r)));
          }
        });
      },
    );

    on<ChangeSelectAdvantageEvent>(
      (event, emit) {
        final List<CarAdvantage> oldData = state.getState(HomeState.carAdvantage).data;
        emit(state.updateData<List<CarAdvantage>>(HomeState.carAdvantage,
            oldData.map((element) => element == event.carAdvantage ? element.copyWith(isSelect: !element.isSelect) : element).toList()));
      },
    );

    on<PickPhotosOrder>((event, emit) async {
      final List<File?>? photos = await SecureFilePicker.pickMultiImage(context: event.context);
      if (photos != null) {
        add(UploadPhotosEvent(photos: photos));
      }
    });
  }
}
