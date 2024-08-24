import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqla_driver/features/app/presentation/widgets/states/error_page.dart';

import '../app_loading_indicator.dart';
import 'empty_page.dart.dart';

class AppCommonStateBuilder<B extends StateStreamable<BaseState>, T> extends StatelessWidget {
  final String? stateName;
  final Widget Function(T data) onSuccess;
  final void Function()? onErrorPressed;
  final void Function()? onEmptyPressed;

  final Widget? onLoading;
  final Widget? onInit;
  final Widget? onEmpty;
  final Widget Function(dynamic exception)? onError;
  final bool isSliver;
  final Size? appErrorPageSize;
  final Size? size;

  const AppCommonStateBuilder({
    super.key,
    this.appErrorPageSize,
    this.isSliver = false,
    this.stateName,
    required this.onSuccess,
    this.onInit,
    this.onEmpty,
    this.onError,
    this.onLoading,
    this.onErrorPressed,
    this.onEmptyPressed,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ResultBuilder<B, T>(
      stateName: stateName,
      loaded: onSuccess,
      loading: onLoading ??
          (isSliver
              ? const SliverToBoxAdapter(
                  child: AppLoadingIndicator(),
                )
              : const AppLoadingIndicator()),
      initial: onInit ??
          (isSliver
              ? const SliverToBoxAdapter(
                  child: Text("init"),
                )
              : const Text("init")),
      empty: (message) =>
          onEmpty ??
          (isSliver
              ? const SliverToBoxAdapter(
                  child: EmptyPage(),
                )
              : const EmptyPage()),
      failure: onError ??
          (errorMessage) => isSliver
              ? SliverToBoxAdapter(
                  child: ErrorPage(
                    errorMessage: errorMessage.toString(),
                  ),
                )
              : ErrorPage(
                  errorMessage: errorMessage.toString(),
                ),
    );
  }
}
