// ignore_for_file: null_check_on_nullable_type_parameter

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../common_state.dart';

extension StateUtils<T> on CommonState<T> {
  bool get isInitial => this is InitialState;

  bool get isLoading => this is LoadingState;

  bool get isError => this is FailureState;

  bool get isSuccess => this is SuccessState;

  bool get isEmpty => this is EmptyState;

  dynamic get error {
    if (this is FailureState) return (this as FailureState).failure;
    return null;
  }

  T? get data {
    if (this is SuccessState) return (this as SuccessState).data;
    return null;
  }

  @Deprecated('Use state.updateData instead, will be removed in next releases.')
  SuccessState<T> updateSuccessState(T updatedData) {
    if (this is! SuccessState && this is! EmptyState<T>) {
      throw UnsupportedError(
        'Tried calling updateSuccessState on non SuccessState,  $runtimeType is not SuccessState nor EmptyState',
      );
    }

    return SuccessState<T>(updatedData);
  }

  void refreshPagingController() {
    if (this is! PaginationState) {
      throw UnsupportedError(
        'Tried calling refreshPagingController on non PaginationState, $runtimeType is not PaginationState',
      );
    }

    final pagingController = (this as PaginationState).pagingController;

    pagingController.refresh();
  }

  PagingController get pagingController {
    if (this is! PaginationState) {
      throw UnsupportedError(
        'Tried reaching for pagingController on non PaginationState, $runtimeType is not PaginationState',
      );
    }

    return (this as PaginationState).pagingController;
  }

  Future<void> handelResult({
    void Function(T data)? onSuccess,
    void Function(dynamic failure)? onError,
    void Function()? onLoading,
    void Function()? onEmpty,
  }) async {
    if (this is SuccessState) {
      onSuccess?.call(data!);
      return;
    }

    if (this is FailureState) {
      onError?.call(error!);
      return;
    }

    if (this is LoadingState) {
      onLoading?.call();
      return;
    }

    if (this is EmptyState) {
      onEmpty?.call();
      return;
    }
  }
}
