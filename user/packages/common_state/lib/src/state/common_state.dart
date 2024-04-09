import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

abstract class CommonState<T> extends BaseState {
  final String? name;
  const CommonState([this.name]);
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(dynamic failure) failure,
    required Widget Function(T data) success,
    required Widget Function([String?]) empty,
  });
}

final class InitialState<T> extends CommonState<T> {
  const InitialState([super.name]);
  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(dynamic failure) failure,
    required Widget Function(T data) success,
    required Widget Function([String?]) empty,
  }) =>
      initial();
}

final class LoadingState<T> extends CommonState<T> {
  const LoadingState([super.name]);
  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(dynamic failure) failure,
    required Widget Function(T data) success,
    required Widget Function([String?]) empty,
  }) =>
      loading();
}

final class EmptyState<T> extends CommonState<T> {
  final String? message;
  const EmptyState([this.message]);
  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(dynamic failure) failure,
    required Widget Function(T data) success,
    required Widget Function([String?]) empty,
  }) =>
      empty(this.message);
}

final class FailureState<T> extends CommonState<T> {
  final dynamic failure;

  const FailureState(this.failure, {String? name}) : super(name);

  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(dynamic failure) failure,
    required Widget Function(T data) success,
    required Widget Function([String?]) empty,
  }) =>
      failure(this.failure);
}

final class SuccessState<T> extends CommonState<T> {
  final T data;

  const SuccessState(this.data, {String? name}) : super(name);

  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(dynamic failure) failure,
    required Widget Function(T data) success,
    required Widget Function([String?]) empty,
  }) =>
      success(this.data);
}

final class PaginationState<T extends BasePagination, P> extends CommonState {
  final PagingController<int, P> pagingController;

  PaginationState([super.name, PagingController<int, P>? pagingController])
      : pagingController = pagingController ?? PagingController<int, P>(firstPageKey: 0);

  @override
  Widget when<Widget>({
    required Widget Function() initial,
    required Widget Function() loading,
    required Widget Function(dynamic) failure,
    required Widget Function(T data) success,
    required Widget Function([String?]) empty,
  }) =>
      const SizedBox.shrink() as Widget;
}
