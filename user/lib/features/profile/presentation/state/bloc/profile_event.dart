part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetPersonalInfoEvent extends ProfileEvent {}

class EditPersonalInfoEvent extends ProfileEvent {
  final EditPersonalInfoParam param;
  final Function(dynamic) onSuccess;

  EditPersonalInfoEvent(this.param, this.onSuccess);
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
