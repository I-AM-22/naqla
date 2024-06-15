part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class DeleteAccountEvent extends ProfileEvent {
  final VoidCallback onSuccess;

  DeleteAccountEvent(this.onSuccess);
}

class UpdatePhoneNumberEvent extends ProfileEvent {
  final String phoneNumber;
  final VoidCallback onSuccess;

  UpdatePhoneNumberEvent(this.phoneNumber, this.onSuccess);
}

class PickImageEvent extends ProfileEvent {
  final ImageSource source;
  final BuildContext context;
  final Function(dynamic) onSuccess;
  PickImageEvent(this.source, this.context, this.onSuccess);
}

class UploadSinglePhotoEvent extends ProfileEvent {
  final UploadSinglePhotoParam param;

  UploadSinglePhotoEvent(this.param);
}

class EditPersonalInfoEvent extends ProfileEvent {
  final EditPersonalInfoParam param;
  final Function(dynamic) onSuccess;

  EditPersonalInfoEvent(this.param, this.onSuccess);
}

class ConfirmEvent extends ProfileEvent {
  final String otp;
  final VoidCallback onSuccess;

  ConfirmEvent({required this.otp, required this.onSuccess});
}
