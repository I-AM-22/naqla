part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class GetAllCarsEvent extends AppEvent {}

class ChangeCarSelected extends AppEvent {
  final String id;
  final bool isSelected;

  ChangeCarSelected({required this.id, required this.isSelected});
}
