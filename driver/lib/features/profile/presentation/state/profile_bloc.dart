import 'dart:io';

import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/auth/data/model/driver_model.dart';
import 'package:naqla_driver/features/profile/domain/usecases/get_profile_use_case.dart';

import '../../../../core/util/secure_image_picker.dart';
import '../../../auth/data/model/login_model.dart';
import '../../../auth/domain/usecases/verification_phone_number_use_case.dart';
import '../../domain/usecases/delete_account_use_case.dart';
import '../../domain/usecases/edit_personal_info_use_case.dart';
import '../../domain/usecases/update_phone_number_use_case.dart';
import '../../domain/usecases/upload_single_photo_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@lazySingleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final EditPersonalInfoUseCase _editPersonalInfoUseCase;
  final UploadSinglePhotoUseCase _uploadSinglePhotoUseCase;
  final UpdatePhoneNumberUseCase _updatePhoneNumberUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final VerificationPhoneNumberUseCase verificationPhoneNumberUseCase;
  ProfileBloc(this.getProfileUseCase, this._editPersonalInfoUseCase, this._uploadSinglePhotoUseCase, this._updatePhoneNumberUseCase,
      this._deleteAccountUseCase, this.verificationPhoneNumberUseCase)
      : super(ProfileState()) {
    multiStateApiCall(
      ProfileState.getProfile,
      (event) => getProfileUseCase(NoParams()),
    );

    multiStateApiCall<EditPersonalInfoEvent, DriverModel>(
      ProfileState.editPersonalInfo,
      (event) => _editPersonalInfoUseCase(event.param),
      onSuccess: (data, event, emit) async {
        emit(state.updateData<DriverModel>(ProfileState.getProfile, data));
        event.onSuccess(data);
      },
    );

    multiStateApiCall<UpdatePhoneNumberEvent, String>(
      ProfileState.editPhoneNumber,
      (event) => _updatePhoneNumberUseCase(event.phoneNumber),
      onSuccess: (data, event, emit) async {
        emit(state.copyWith(phone: event.phoneNumber));
        event.onSuccess();
      },
    );

    multiStateApiCall<ConfirmEvent, LoginModel>(
      ProfileState.confirm,
      (event) => verificationPhoneNumberUseCase(VerificationPhoneNumberParam(otp: event.otp, phone: state.phone, phoneConfirm: true)),
      onSuccess: (data, event, emit) async {
        emit(state.updateData(ProfileState.getProfile, data.driver));
        event.onSuccess();
      },
    );

    multiStateApiCall<UploadSinglePhotoEvent, String>(
      ProfileState.uploadSinglePhoto,
      (event) => _uploadSinglePhotoUseCase(event.param),
    );

    multiStateApiCall<DeleteAccountEvent, void>(
      ProfileState.deleteAccount,
      (event) => _deleteAccountUseCase(NoParams()),
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
