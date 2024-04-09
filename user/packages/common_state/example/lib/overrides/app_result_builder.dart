import 'package:common_state/common_state.dart';
import 'package:example/models/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppResultBuilder<B extends StateStreamable<BaseState>, T> extends StatelessWidget {
  const AppResultBuilder({
    Key? key,
    required this.loaded,
    this.empty,
    this.initial,
    this.loading,
    this.failure,
    this.stateName,
  }) : super(key: key);

  final String? stateName;
  final Widget Function(T data) loaded;

  final Widget Function(CustomErrorType failure)? failure;
  final Widget Function(String? message)? empty;
  final Widget? initial;
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return ResultBuilder<B, T>(
      stateName: stateName,
      loaded: loaded,
      empty: empty ?? (_) => const Text('empty', style: TextStyle(fontSize: 30)),
      initial: initial ?? const Text('InitialState', style: TextStyle(fontSize: 30)),
      loading: loading ?? const Text('loading', style: TextStyle(fontSize: 30)),
      failure: failure != null
          ? (error) => failure!(error)
          : (failure) => const Text('failure', style: TextStyle(fontSize: 30)),
    );
  }
}
