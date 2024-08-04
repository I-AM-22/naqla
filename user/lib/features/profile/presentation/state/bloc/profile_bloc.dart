import 'dart:io';

import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/core/util/secure_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../auth/data/model/auth_model.dart';
import '../../../../auth/data/model/user_model.dart';
import '../../../../auth/domain/use_cases/confirm_use_case.dart';
import '../../../domain/use_cases/delete_account_use_case.dart';
import '../../../domain/use_cases/edit_personal_info_use_case.dart';
import '../../../domain/use_cases/get_personal_info_use_case.dart';
import '../../../domain/use_cases/update_phone_number_use_case.dart';
import '../../../domain/use_cases/upload_single_photo_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@lazySingleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetPersonalInfoUseCase _personalInfoUseCase;
  final EditPersonalInfoUseCase _editPersonalInfoUseCase;
  final UploadSinglePhotoUseCase _uploadSinglePhotoUseCase;
  final UpdatePhoneNumberUseCase _updatePhoneNumberUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final ConfirmUseCase _confirmUseCase;
  ProfileBloc(this._personalInfoUseCase, this._editPersonalInfoUseCase, this._uploadSinglePhotoUseCase, this._updatePhoneNumberUseCase,
      this._deleteAccountUseCase, this._confirmUseCase)
      : super(ProfileState()) {
    multiStateApiCall<GetPersonalInfoEvent, User>(ProfileState.getPersonalInfo, (event) => _personalInfoUseCase(NoParams()));

    multiStateApiCall<ConfirmEvent, AuthModel>(
      ProfileState.confirm,
      (event) => _confirmUseCase(event.param),
      onSuccess: (data, event, emit) async {
        emit(state.updateData(ProfileState.getPersonalInfo, data.user));
        event.onSuccess(data);
      },
    );

    multiStateApiCall<EditPersonalInfoEvent, User>(
      ProfileState.editPersonalInfo,
      (event) => _editPersonalInfoUseCase(event.param),
      onSuccess: (data, event, emit) async {
        emit(state.updateData<User>(ProfileState.getPersonalInfo, data));
        event.onSuccess(data);
      },
    );

    multiStateApiCall<UpdatePhoneNumberEvent, String>(
      ProfileState.editPhoneNumber,
      (event) => _updatePhoneNumberUseCase(event.param),
      onSuccess: (data, event, emit) async {
        event.onSuccess(data);
      },
    );

    multiStateApiCall<UploadSinglePhotoEvent, String>(
      ProfileState.uploadSinglePhoto,
      (event) => _uploadSinglePhotoUseCase(event.param),
    );

    multiStateApiCall<DeleteAccountEvent, void>(
      ProfileState.deleteAccount,
      (event) => _deleteAccountUseCase(NoParams()),
      onSuccess: (data, event, emit) async => event.onSuccess(),
    );

    on<PickImageEvent>((event, emit) async {
      emit(state.updateState(ProfileState.pickImage, const LoadingState()));
      final image = await SecureFilePicker.pickImage(event.source, context: event.context, cropAspectRatio: CropAspectRatioPreset.square);
      if (image != null) {
        emit(state.updateState(ProfileState.pickImage, SuccessState<File?>(image)));
        event.onSuccess(image);
        add(UploadSinglePhotoEvent(UploadSinglePhotoParam(image)));
      } else {
        emit(state.updateState(ProfileState.pickImage, const EmptyState()));
      }
    });
  }
}
