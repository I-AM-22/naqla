import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';
import 'package:intl/src/intl/date_format.dart';
import '../../features/app/domain/repository/prefs_repository.dart';
import '../../features/app/presentation/widgets/animated_dialog.dart';
import '../../features/on_boarding/presentation/pages/on_boarding_screen.dart';
import '../../generated/l10n.dart';
import '../api/exceptions.dart';
import '../common/model/pagenatio_model.dart';
import '../di/di_container.dart';
import '../type_definitions.dart';

class CoreHelperFunctions {
  /// Cast to [T] if possible or return null
  T? castOrNull<T>(x) => x is T ? x : null;

  static void logOut(BuildContext context) => AnimatedDialog.show(context,
      child: Padding(
        padding: REdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.titleSmall(S.of(context).logOut),
            4.verticalSpace,
            AppText.bodyMedium(S.of(context).are_you_sure_you_want_to_log_out),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppButton.ghost(
                    style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => context.colorScheme.error)),
                    buttonSize: ButtonSize.medium,
                    child: AppText.bodySmall(
                      S.of(context).logOut,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await getIt<PrefsRepository>().clearUser();
                      if (!context.mounted) return;
                      context.goNamed(OnBoardingScreen.name);
                    }),
                AppButton.ghost(
                  buttonSize: ButtonSize.medium,
                  child: AppText.bodySmall(S.of(context).cancel),
                  onPressed: () {
                    context.pop(S.of(context).cancel);
                  },
                )
              ],
            )
          ],
        ),
      ));

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

  static String fromDateTimeToString(DateTime dateTime) => DateFormat("${DateFormat.DAY} ${DateFormat.MONTH} ${DateFormat.YEAR}").format(dateTime);

  static String fromTimeToString(DateTime dateTime) => DateFormat.Hm().format(dateTime);

  static String timeOfDayToString(TimeOfDay time) => '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';

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
      (response is List && response.isEmpty) || (emptyChecker != null && emptyChecker(response));

  static bool isLastPage(PaginationModel right) => ((right.totalPages) - 1) == (right.pageNumber);

  static bool hasReachedMax({required int totalPage, required int pageNumber}) =>
      totalPage == 0 ? totalPage == pageNumber : totalPage == pageNumber + 1;

  static CommonState? getCommonState<T>(Map<int, CommonState> state, int index) => state[index];
}
