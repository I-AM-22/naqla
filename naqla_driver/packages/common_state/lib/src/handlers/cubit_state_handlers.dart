import 'package:common_state/src/handlers/base_state_handler.dart';

import '../../common_state.dart';

class CubitStateHandlers {
  static Future<void> apiCall<T>({
    required FutureResult<T> Function() apiCall,
    required void Function(CommonState<T>) emit,
    Future<void> Function()? preCall,
    Future<void> Function(T data)? onSuccess,
    Future<void> Function(dynamic failure)? onFailure,
    bool Function(T data)? emptyChecker,
    String? emptyMessage,
  }) =>
      BaseHandler.apiCall(
        apiCall: apiCall,
        emit: emit,
        emptyChecker: emptyChecker,
        emptyMessage: emptyMessage,
        onSuccess: onSuccess,
        onFailure: onFailure,
        preCall: preCall,
      );

  static Future<void> multiStateApiCall<T>({
    required FutureResult<T> Function() apiCall,
    required dynamic emit,
    required StateObject state,
    required String stateName,
    Future<void> Function()? preCall,
    Future<void> Function(T data)? onSuccess,
    Future<void> Function(dynamic failure)? onFailure,
    bool Function(T data)? emptyChecker,
    String? emptyMessage,
  }) =>
      BaseHandler.multiStateApiCall<T>(
        apiCall: apiCall,
        emit: emit,
        state: state,
        stateName: stateName,
        onSuccess: onSuccess,
        onFailure: onFailure,
        emptyChecker: emptyChecker,
        emptyMessage: emptyMessage,
        preCall: preCall,
      );

  static Future<void> paginatedApiCall<T extends BasePagination, P>({
    required FutureResult<T> Function() apiCall,
    required int pageKey,
    required void Function(PaginationState<T, P>) emit,
    required PaginationState<T, P> state,
    void Function(T data)? onFirstPageFetched,
    Future<void> Function()? preCall,
    bool Function(T data)? isLastPage,
  }) =>
      BaseHandler.paginatedApiCall<T, P>(
        pageKey: pageKey,
        emit: emit,
        state: state,
        apiCall: apiCall,
        onFirstPageFetched: onFirstPageFetched,
        preCall: preCall,
        isLastPage: isLastPage,
      );

  static Future<void> multiStatePaginatedApiCall<T extends BasePagination>({
    required FutureResult<T> Function() apiCall,
    required int pageKey,
    required dynamic emit,
    required StateObject state,
    required String stateName,
    void Function(T data)? onFirstPageFetched,
  }) =>
      BaseHandler.multiStatePaginatedApiCall<T>(
        pageKey: pageKey,
        emit: emit,
        state: state,
        stateName: stateName,
        apiCall: apiCall,
        onFirstPageFetched: onFirstPageFetched,
      );
}
