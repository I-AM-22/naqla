part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class GetAllCarsEvent extends AppEvent {}
