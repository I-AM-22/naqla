import 'package:common_state/common_state.dart';

class CustomPaginationModel implements PaginatedData<String> {
  final String property1;
  final int property2;
  final PaginationModel<String> paginationProperty;

  CustomPaginationModel(this.property1, this.property2, this.paginationProperty);

  @override
  PaginationModel<String> get paginatedData => paginationProperty;
}

class SomPaginatedData implements PaginatedData<String> {
  final int someValue;
  final PaginationModel<String> paginatedValue;

  SomPaginatedData(this.someValue, this.paginatedValue);

  @override
  PaginationModel<String> get paginatedData => paginatedValue;
}

class ExampleProperty {
  final int version;
  final bool isUpdated;

  const ExampleProperty(this.version, this.isUpdated);

  @override
  String toString() => 'ExampleProperty(version: $version, isUpdated: $isUpdated)';
}
