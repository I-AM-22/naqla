
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqla/core/api/exceptions.dart';
import 'package:naqla/core/state_managment/state/common_state.dart';


class ResultBuilder<B extends StateStreamable<CommonState>, T> extends StatelessWidget {
  const ResultBuilder({
    super.key,
    required this.loaded,
    required this.emptyMessage,
    required this.empty,
    required this.initial,
    required this.loading,
    required this.fail,
  });

  final Widget Function(T data) loaded;
  final Widget Function() initial;
  final Widget Function() loading;
  final Widget Function(AppException failure) fail;
  final Widget Function() empty;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, CommonState>(
      builder: (context, state) => state.when(
        initial: () => initial(),
        loading: () => loading(),
        error: (failure) => fail(failure),
        empty: () => empty(),
        success: (data) => loaded(data),
      ),
    );
  }
}
