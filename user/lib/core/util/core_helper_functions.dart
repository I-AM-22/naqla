import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqla/core/core.dart';
import 'package:intl/src/intl/date_format.dart';
import '../api/exceptions.dart';
import '../common/model/pagenatio_model.dart';
import '../type_definitions.dart';

class CoreHelperFunctions {
  /// Cast to [T] if possible or return null
  T? castOrNull<T>(x) => x is T ? x : null;

  //?============================================ State management Helpers ============================================

  /// Manage the state according to the value returned from callback
  static Future<void> handelApiResult<T>({
    bool Function(T)? emptyChecker,
    required FutureResult<T> Function() callback,
    required void Function(CommonState<dynamic>) emit,
    Function(T)? onSuccess,
    Function(AppException)? onFailure,
  }) async {
    emit(const LoadingState());

    final result = await callback();

    result.fold(
      (l) {
        emit(ErrorState(l));
        onFailure?.call(l);
      },
      (r) {
        if (isResponseEmpty(emptyChecker, r)) {
          emit(const EmptyState());
          return;
        }

        emit(SuccessState(r));
        if (onSuccess != null) onSuccess(r);
      },
    );
  }

  static Future<void> handelMultiApiResult<T>({
    required FutureResult<T> Function() callback,
    required Emitter<Map<int, CommonState<T>>> emit,
    required Map<int, CommonState<T>> state,
    required int index,
    Function(T)? onSuccess,
    Function(AppException)? onFailure,
    bool Function(T)? emptyChecker,
  }) async {
    //TODO search how to add constraint to Enum
    // assert(E is Enum, "you can pass only enum class ");

    emit(state.setState(index, LoadingState<T>()));
    final result = await callback();
    result.fold(
      (l) {
        emit(state.setState(index, ErrorState<T>(l)));
        onFailure?.call(l);
      },
      (r) {
        if (isResponseEmpty(emptyChecker, r)) {
          emit(state.setState(index, EmptyState<T>()));
          return;
        }
        emit(state.setState(index, SuccessState<T>(r)));
        if (onSuccess != null) {
          onSuccess(r);
        }
      },
    );
  }

  static Future<void> handlePagination<T>({
    ///TODO: ADD DOCS TO GET DATA AND DATA
    FutureResult<PaginationModel<T>> Function()? getData,
    PaginationModel<T>? data,
    required int pageKey,
    required Emitter<Map<int, CommonState<T>>> emit,
    required Map<int, CommonState<T>> state,
    required int index,
  }) async {
    // assert(
    //     data == null && getData == null, "you should pass get data or data ");
    final d = state[index];
    if (d is PaginationClass) {
      final d = state[index] as PaginationClass<T>;
      final controller = d.pagingController;

      if (data != null) {
        final isLastPage = CoreHelperFunctions.isLastPage(data);
        if (isLastPage) {
          controller.appendLastPage(data.data);
        } else {
          controller.appendPage(data.data, pageKey + 1);
        }
      } else {
        final newItems = await getData?.call();
        newItems?.fold((left) => controller.error = left.message, (right) {
          final isLastPage = CoreHelperFunctions.isLastPage(right);
          if (isLastPage) {
            controller.appendLastPage(right.data);
          } else {
            controller.appendPage(right.data, pageKey + 1);
          }
        });
      }
    }
  }

  //?============================================ Date & Time helpers ============================================

  static String fromDateTimeToString(DateTime dateTime) =>
      DateFormat("${DateFormat.DAY} ${DateFormat.MONTH} ${DateFormat.YEAR}")
          .format(dateTime);

  static String fromTimeToString(DateTime dateTime) =>
      DateFormat.Hm().format(dateTime);

  static String timeOfDayToString(TimeOfDay time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';

  ///Converts from [TimeOfDay] to [DateTime]
  static DateTime timeOfDayToDateTime(TimeOfDay timeOfDay) => DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        timeOfDay.hour,
        timeOfDay.minute,
      );

  //============================================== Inner Helper Functions ==============================================

  static bool isResponseEmpty<T>(bool Function(T)? emptyChecker, T response) =>
      (response is List && response.isEmpty) ||
      (emptyChecker != null && emptyChecker(response));

  static bool isLastPage(PaginationModel right) =>
      ((right.totalPages) - 1) == (right.pageNumber);

  static bool hasReachedMax(
          {required int totalPage, required int pageNumber}) =>
      totalPage == 0 ? totalPage == pageNumber : totalPage == pageNumber + 1;

  static CommonState? getCommonState<T>(
          Map<int, CommonState> state, int index) =>
      state[index];
}
