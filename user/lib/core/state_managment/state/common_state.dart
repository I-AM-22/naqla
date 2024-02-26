import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:naqla/core/api/exceptions.dart';


extension StateChecker on CommonState {
  bool isInitial() => this is InitialState;

  bool isLoading() => this is LoadingState;

  bool isError() => this is ErrorState;

  bool isSuccess() => this is SuccessState;

  AppException? get error => this is ErrorState ? (this as ErrorState).error : null;
}

sealed class CommonState<T> {
  const CommonState();
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(AppException) error,
    required Widget Function(T) success,
    required Widget Function() empty,
  });
}

final class InitialState<T> extends CommonState<T> {
  const InitialState();
  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(AppException) error,
    required Widget Function(T) success,
    required Widget Function() empty,
  }) =>
      initial();
}

final class LoadingState<T> extends CommonState<T> {
  const LoadingState();
  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(AppException) error,
    required Widget Function(T) success,
    required Widget Function() empty,
  }) =>
      loading();
}

final class EmptyState<T> extends CommonState<T> {
  const EmptyState();
  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(AppException) error,
    required Widget Function(T) success,
    required Widget Function() empty,
  }) =>
      empty();
}

final class ErrorState<T> extends CommonState<T> {
  final AppException error;

  const ErrorState(this.error);

  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(AppException) error,
    required Widget Function(T) success,
    required Widget Function() empty,
  }) =>
      error(this.error);
}

final class SuccessState<T> extends CommonState<T> {
  final T data;

  const SuccessState(this.data);

  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(AppException) error,
    required Widget Function(T) success,
    required Widget Function() empty,
  }) =>
      success(this.data);
}

final class PaginationClass<T> extends CommonState {
  final PagingController<int, T> pagingController;

  const PaginationClass({required this.pagingController});

  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(AppException) error,
    required Widget Function(T) success,
    required Widget Function() empty,
  }) {
    ///this will not needed
    return const SizedBox() as Widget;
  }
}
