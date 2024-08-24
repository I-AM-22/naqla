import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// A Custom delegate that substitute the original [PagedChildBuilderDelegate]
class PagedBuilderDelegate<ItemType> {
  PagedBuilderDelegate({
    required this.itemBuilder,
    this.firstPageErrorIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.animateTransitions = false,
    this.transitionDuration = const Duration(milliseconds: 250),
  });

  final ItemWidgetBuilder<ItemType> itemBuilder;
  final Widget Function(dynamic error, VoidCallback onRetry)? firstPageErrorIndicatorBuilder;
  final Widget Function(dynamic error, VoidCallback onRetry)? newPageErrorIndicatorBuilder;
  final Widget? firstPageProgressIndicatorBuilder;
  final Widget? newPageProgressIndicatorBuilder;
  final Widget? noItemsFoundIndicatorBuilder;
  final Widget? noMoreItemsIndicatorBuilder;
  final bool animateTransitions;
  final Duration transitionDuration;
}
