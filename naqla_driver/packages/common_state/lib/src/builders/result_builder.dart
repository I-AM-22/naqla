import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultBuilder<B extends StateStreamable<BaseState>, T> extends StatelessWidget {
  const ResultBuilder({
    Key? key,
    required this.loaded,
    this.empty,
    this.initial,
    this.loading,
    this.failure,
    this.stateName,
  }) : super(key: key);

  final Widget Function(T data) loaded;
  final Widget Function(dynamic failure)? failure;
  final Widget Function(String? message)? empty;
  final Widget? initial;
  final Widget? loading;
  final String? stateName;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, BaseState, CommonState<T>>(
      selector: (state) {
        if (state is CommonState<T>) return state;

        if (state is StateObject) {
          if (stateName == null) {
            throw ArgumentError('State name not provided for StateObject in ResultBuilder widget');
          }
          return state.getState(stateName!) as CommonState<T>;
        }

        throw UnsupportedError('Unsupported state type given to ResultBuilder widget');
      },
      builder: (context, state) => state.when(
        initial: () => Center(child: initial ?? const Text('InitialState', style: TextStyle(fontSize: 30))),
        loading: () => loading ?? const Center(child: CircularProgressIndicator()),
        failure: (error) =>
            failure != null ? failure!(error) : const Text('FailureState', style: TextStyle(fontSize: 30)),
        empty: ([message]) =>
            empty != null ? empty!(message) : const Text('empty', style: TextStyle(fontSize: 30)),
        success: (data) => loaded(data),
      ),
    );
  }
}
