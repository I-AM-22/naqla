import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqla/core/api/exceptions.dart';
import 'package:naqla/core/state_managment/result_builder/result_builder.dart';
import 'package:naqla/core/state_managment/state/common_state.dart';
import 'package:naqla/features/app/presentation/widgets/app_loading_indicator.dart';

import 'empty_page.dart.dart';
import 'error_page.dart';

class AppResultBuilder<B extends StateStreamable<CommonState>, T> extends StatelessWidget {
  const AppResultBuilder({
    super.key,
    required this.loaded,
    this.initial,
    this.loading,
    this.fail,
    this.empty,
    this.emptyMessage,
  });

  final Widget Function(T data) loaded;
  final Widget Function()? initial;
  final Widget Function()? loading;
  final Widget Function(AppException failure)? fail;
  final Widget Function()? empty;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return ResultBuilder<B, T>(
      loaded: loaded,
      emptyMessage: emptyMessage,
      empty: empty ?? () => const EmptyPage(),
      initial: initial ?? () => const AppLoadingIndicator(),
      loading: loading ?? () => const AppLoadingIndicator(),
      fail: fail ?? (failure) => const ErrorPage(),
    );
  }
}
