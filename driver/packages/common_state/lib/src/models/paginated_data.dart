import 'package:common_state/src/models/base_pagination.dart';
import 'package:common_state/src/models/pagination_model.dart';

/// Abstract class for models that contain paginated data to be handled by the package
/// [T] is the data type inside the pagination model
abstract class PaginatedData<T> implements BasePagination<T> {
  PaginationModel<T> get paginatedData;
}
