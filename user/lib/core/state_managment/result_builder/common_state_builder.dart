import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqla/core/api/exceptions.dart';
import 'package:naqla/core/state_managment/state/common_state.dart';

/// B is Bloc
/// T is Enum and should extends from Helper
/// D is data
/// [Example ] CommonStateBuilder<HomeBloc>(state: TestState.getProduct),
class CommonStateBuilder<B extends StateStreamable<Map<int, CommonState>>, T>
    extends StatelessWidget {
  const CommonStateBuilder({
    super.key,
    required this.index,
    required this.onSuccess,
    required this.onLoading,
    required this.onInit,
    required this.onEmpty,
    required this.onError,
  });

  final int index;
  final Widget Function(T data) onSuccess;
  final Widget onLoading;

  final Widget onInit;
  final Widget onEmpty;
  final Widget Function(AppException exception) onError;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, Map<int, CommonState>, CommonState>(
      selector: (state) => state[index]!,
      builder: (context, state) {
        if (state is PaginationClass) {
          return const Text("you should use CommonStatePaginationBuilder");
        } else {
          return state.when(
            initial: () => onInit,
            loading: () => onLoading,
            error: (r) => onError(r),
            success: (data) => onSuccess(data),
            empty: () => onEmpty,
          );
        }
      },
    );
  }
}
