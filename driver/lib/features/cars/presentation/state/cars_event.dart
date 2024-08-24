part of 'cars_bloc.dart';

@immutable
sealed class CarsEvent {}

class GetAllCarsEvent extends CarsEvent {}

class ChangeCarSelected extends CarsEvent {
  final String id;
  final bool isSelected;

  ChangeCarSelected({required this.id, required this.isSelected});
}

class DeleteCarEvent extends CarsEvent {
  final String id;
  final VoidCallback onSuccess;

  DeleteCarEvent({required this.id, required this.onSuccess});
}

class EditCarEvent extends CarsEvent {
  final EditCarParam param;
  final VoidCallback onSuccess;

  EditCarEvent({required this.param, required this.onSuccess});
}

class AddCarEvent extends CarsEvent {
  final AddCarParam param;
  final VoidCallback onSuccess;

  AddCarEvent({required this.param, required this.onSuccess});
}

class GetCarAdvantageEvent extends CarsEvent {
  final List<CarAdvantage>? advantages;

  GetCarAdvantageEvent({this.advantages});
}

class ChangeSelectAdvantageEvent extends CarsEvent {
  final CarAdvantage carAdvantage;

  ChangeSelectAdvantageEvent({required this.carAdvantage});
}
