import 'package:flutter/material.dart';

import 'page_state.dart';

class PageStateBuilder<T> extends StatelessWidget {
  const PageStateBuilder({
    Key? key,
    required this.init,
    required this.success,
    required this.loading,
    required this.error,
    required this.result,
    required this.empty,
  }) : super(key: key);

  final PageState<T> result;
  final Widget init;
  final Widget loading;
  final Widget Function(T data) success;
  final Widget Function(Exception? error) error;
  final Widget empty;

  @override
  Widget build(BuildContext context) {
    late final Widget next;
    result.when(
      init: () => next = init,
      loading: () => next = loading,
      loaded: (data) => next = success(data),
      error: (e) => next = error(e),
      empty: () => next = empty,
    );
    return next;
  }
}
