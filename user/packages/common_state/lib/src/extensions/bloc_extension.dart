// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_state.dart';

extension BlocExtension<Event, State extends StateObject<State>> on Bloc<Event, State> {
  /// Used to handle Calls for a bloc with multiple [CommonState]
  /// [E] is the event type
  /// [T] is the data type
  /// [stateName] is the name of the state to be updated
  /// this will call the [apiCall] function and update the state with the result
  void multiStateApiCall<E extends Event, T>(
    String stateName,
    FutureResult<T> Function(E event) apiCall, {
    Future<void> Function(E event, Emitter<State> emit)? preCall,
    Future<void> Function(T data, E event, Emitter<State> emit)? onSuccess,
    Future<void> Function(dynamic failure, E event, Emitter<State> emit)? onFailure,
    bool Function(T)? emptyChecker,
    String? emptyMessage,
    EventTransformer<E>? transformer,
  }) =>
      on<E>(
        (event, emit) async => await BlocStateHandlers.multiStateApiCall<T>(
          emit: emit,
          state: state,
          stateName: stateName,
          apiCall: () => apiCall(event),
          preCall: () async => preCall?.call(event, emit),
          onSuccess: (data) async => onSuccess?.call(data, event, emit),
          onFailure: (failure) async {
            addError(failure, StackTrace.current);
            await onFailure?.call(failure, event, emit);
          },
          emptyChecker: emptyChecker,
          emptyMessage: emptyMessage,
        ),
        transformer: transformer,
      );

  /// Used to handle Calls for a bloc with multiple [CommonState] and pagination
  /// [E] is the event type
  /// [T] is the data type, must be a subclass of [BasePagination]
  /// [stateName] is the name of the state to be updated
  /// this will call the [apiCall] function and update the pagination state with the result
  void multiStatePaginatedApiCall<E extends Event, T extends BasePagination>(
    String stateName,
    FutureResult<T> Function(E event) apiCall,
    int Function(E event) pageKey, {
    void Function(E event, Emitter<State> emit, T data)? onFirstPageFetched,
    Future<void> Function(E event, Emitter<State> emit)? preCall,
    EventTransformer<E>? transformer,
  }) =>
      on<E>(
        (event, emit) async => await BlocStateHandlers.multiStatePaginatedApiCall<T, dynamic>(
          preCall: () async => preCall?.call(event, emit),
          apiCall: () => apiCall(event),
          stateName: stateName,
          pageKey: pageKey(event),
          emit: emit,
          state: state,
          onFirstPageFetched: (data) => onFirstPageFetched?.call(event, emit, data),
        ),
        transformer: transformer,
      );
}
