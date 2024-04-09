part of 'bloc.dart';

abstract class CommonStateEvent {}

class Fetch extends CommonStateEvent {}

class FetchPagination extends CommonStateEvent {
  final int pageKey;

  FetchPagination({required this.pageKey});
}

class UpdateSomeProperty extends CommonStateEvent {
  final bool newValue;
  UpdateSomeProperty(this.newValue);
}

class UpdateExampleProperty extends CommonStateEvent {
  final ExampleProperty newExampleProperty;
  UpdateExampleProperty(this.newExampleProperty);
}
