import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqla/core/api/exceptions.dart';
import 'package:naqla/core/state_managment/result_builder/common_state_builder.dart';
import 'package:naqla/core/state_managment/state/common_state.dart';
import 'package:naqla/features/app/presentation/widgets/app_loading_indicator.dart';
import 'package:naqla/features/app/presentation/widgets/states/error_page.dart';

import 'empty_page.dart.dart';

class AppCommonStateBuilder<B extends StateStreamable<Map<int, CommonState>>, T> extends StatelessWidget {
  final int index;
  final Widget Function(T data) onSuccess;

  final Widget? onLoading;
  final Widget? onInit;
  final Widget? onEmpty;
  final Widget Function(AppException exception)? onError;

  const AppCommonStateBuilder({
    super.key,
    required this.index,
    required this.onSuccess,
    this.onInit,
    this.onEmpty,
    this.onError,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return CommonStateBuilder<B, T>(
      index: index,
      onSuccess: onSuccess,
      onLoading: onLoading ?? const AppLoadingIndicator(),
      onInit: onInit ?? const Text("init"),
      onEmpty: onEmpty ?? const EmptyPage(),
      onError: onError ?? (errorMessage) => const ErrorPage(),
    );
  }
}
