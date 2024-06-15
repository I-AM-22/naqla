part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class GetAllCarsEvent extends AppEvent {}

class ChangeCarSelected extends AppEvent {
  final String id;
  final bool isSelected;

  ChangeCarSelected({required this.id, required this.isSelected});
}

class DeleteCarEvent extends AppEvent {
  final String id;
  final VoidCallback onSuccess;

  DeleteCarEvent({required this.id, required this.onSuccess});
}

class EditCarEvent extends AppEvent {
  final AddCarParam param;
  final VoidCallback onSuccess;

  EditCarEvent({required this.param, required this.onSuccess});
}

class AddCarEvent extends AppEvent {
  final AddCarParam param;
  final VoidCallback onSuccess;

  AddCarEvent({required this.param, required this.onSuccess});
}

class ChangeSelectAdvantageEvent extends AppEvent {
  final CarAdvantage carAdvantage;

  ChangeSelectAdvantageEvent({required this.carAdvantage});
}

class GetCarAdvantageEvent extends AppEvent {
  final List<CarAdvantage>? advantages;

  GetCarAdvantageEvent({this.advantages});
}
