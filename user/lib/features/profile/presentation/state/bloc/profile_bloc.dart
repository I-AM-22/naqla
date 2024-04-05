import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/core/util/core_helper_functions.dart';
import 'package:naqla/core/util/secure_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../auth/data/model/user_model.dart';
import '../../../domain/use_cases/delete_account_use_case.dart';
import '../../../domain/use_cases/edit_personal_info_use_case.dart';
import '../../../domain/use_cases/get_personal_info_use_case.dart';
import '../../../domain/use_cases/update_phone_number_use_case.dart';
import '../../../domain/use_cases/upload_single_photo_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, Map<int, CommonState>> {
  final GetPersonalInfoUseCase _personalInfoUseCase;
  final EditPersonalInfoUseCase _editPersonalInfoUseCase;
  final UploadSinglePhotoUseCase _uploadSinglePhotoUseCase;
  final UpdatePhoneNumberUseCase _updatePhoneNumberUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  ProfileBloc(this._personalInfoUseCase, this._editPersonalInfoUseCase, this._uploadSinglePhotoUseCase, this._updatePhoneNumberUseCase,
      this._deleteAccountUseCase)
      : super(ProfileState.iniState) {
    on<GetPersonalInfoEvent>((event, emit) {
      return CoreHelperFunctions.handelMultiApiResult(
          callback: () async => _personalInfoUseCase(NoParams()), emit: emit, state: state, index: ProfileState.getPersonalInfo);
    });

    on<EditPersonalInfoEvent>((event, emit) {
      return CoreHelperFunctions.handelMultiApiResult(
          callback: () async => _editPersonalInfoUseCase(event.param),
          emit: emit,
          onSuccess: (data) {
            final oldState = CoreHelperFunctions.getCommonState(state, ProfileState.getPersonalInfo);
            if (oldState is SuccessState) {
              emit(state.setState(ProfileState.getPersonalInfo, SuccessState(data)));
            }
            event.onSuccess.call(data);
          },
          state: state,
          index: ProfileState.editPersonalInfo);
    });

    on<UpdatePhoneNumberEvent>((event, emit) {
      return CoreHelperFunctions.handelMultiApiResult(
          callback: () async => _updatePhoneNumberUseCase(event.param),
          emit: emit,
          onSuccess: event.onSuccess,
          state: state,
          index: ProfileState.editPhoneNumber);
    });

    on<UploadSinglePhotoEvent>((event, emit) {
      return CoreHelperFunctions.handelMultiApiResult(
          callback: () async => _uploadSinglePhotoUseCase(event.param), emit: emit, state: state, index: ProfileState.uploadSinglePhoto);
    });

    on<DeleteAccountEvent>((event, emit) {
      return CoreHelperFunctions.handelMultiApiResult(
          callback: () async => _deleteAccountUseCase(NoParams()),
          emit: emit,
          state: state,
          onSuccess: event.onSuccess,
          index: ProfileState.deleteAccount);
    });

    on<PickImageEvent>((event, emit) async {
      emit(state.setState(ProfileState.pickImage, const LoadingState<File?>()));
      final image = await SecureFilePicker.pickImage(event.source, context: event.context);
      if (image != null) {
        emit(state.setState(ProfileState.pickImage, SuccessState<File?>(image)));
        event.onSuccess.call(image);
        add(UploadSinglePhotoEvent(UploadSinglePhotoParam(image)));
      } else {
        emit(state.setState(ProfileState.pickImage, const EmptyState<File?>()));
      }
    });
  }
}
