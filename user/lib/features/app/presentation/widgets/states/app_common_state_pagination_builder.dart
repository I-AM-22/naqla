import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:naqla/core/state_managment/result_builder/common_state_pagination_builder.dart';
import 'package:naqla/core/state_managment/state/common_state.dart';

class AppCommonStatePaginationBuilder<
    B extends StateStreamable<Map<int, CommonState>>,
    T> extends StatefulWidget {
  final int index;
  final CommonStatePaginationType _type;
  final bool shrinkWrap;

  final ItemWidgetBuilder<T> itemBuilder;
  final Widget? firstPageErrorIndicatorBuilder;
  final Widget? firstPageProgressIndicatorBuilder;
  final Widget? newPageErrorIndicatorBuilder;
  final Widget? newPageProgressIndicatorBuilder;
  final Widget? noItemsFoundIndicatorBuilder;
  final Widget? noMoreItemsIndicatorBuilder;
  final EdgeInsetsGeometry? padding;
  final SliverGridDelegate? gridDelegate;

  final Axis? scrollDirection;

  final ScrollPhysics? physics;
  final ValueChanged<int> onPageKeyChanged;

  const AppCommonStatePaginationBuilder.pagedListView({
    super.key,
    required this.itemBuilder,
    required this.index,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection,
    this.physics,
    required this.onPageKeyChanged,
    this.shrinkWrap = false,
  })  : _type = CommonStatePaginationType.pagedListView,
        gridDelegate = null;

  const AppCommonStatePaginationBuilder.pagedGridView({
    super.key,
    required this.itemBuilder,
    required this.index,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection,
    this.physics,
    required this.onPageKeyChanged,
    this.shrinkWrap = false,
    this.gridDelegate,
  }) : _type = CommonStatePaginationType.pagedGridView;

  const AppCommonStatePaginationBuilder.pagedSliverList({
    super.key,
    required this.itemBuilder,
    required this.index,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection,
    this.physics,
    required this.onPageKeyChanged,
    this.shrinkWrap = false,
  })  : _type = CommonStatePaginationType.pagedGridView,
        gridDelegate = null;

  const AppCommonStatePaginationBuilder.pagedSliverGrid({
    super.key,
    required this.itemBuilder,
    required this.index,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection,
    this.physics,
    required this.onPageKeyChanged,
    this.shrinkWrap = false,
    this.gridDelegate,
  }) : _type = CommonStatePaginationType.pagedGridView;

  const AppCommonStatePaginationBuilder.pagedPageView({
    super.key,
    required this.itemBuilder,
    required this.index,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection,
    this.physics,
    required this.onPageKeyChanged,
    this.shrinkWrap = false,
  })  : _type = CommonStatePaginationType.pagedGridView,
        gridDelegate = null;

  @override
  State<AppCommonStatePaginationBuilder<B, T>> createState() =>
      _AppCommonStatePaginationBuilderState<B, T>();
}

class _AppCommonStatePaginationBuilderState<
    B extends StateStreamable<Map<int, CommonState>>,
    T> extends State<AppCommonStatePaginationBuilder<B, T>> {
  @override
  void initState() {
    (context.read<B>().state[widget.index] as PaginationClass<T>)
        .pagingController
        .addPageRequestListener((pageKey) {
      widget.onPageKeyChanged(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget._type) {
      case CommonStatePaginationType.pagedListView:
        return CommonStatePaginationBuilder<B, T>.pagedListView(
          index: widget.index,
          itemBuilder: widget.itemBuilder,
          firstPageErrorIndicatorBuilder: widget.firstPageErrorIndicatorBuilder,
          firstPageProgressIndicatorBuilder:
              widget.firstPageProgressIndicatorBuilder,
          newPageErrorIndicatorBuilder: widget.newPageErrorIndicatorBuilder,
          newPageProgressIndicatorBuilder:
              widget.newPageProgressIndicatorBuilder,
          noItemsFoundIndicatorBuilder: widget.noItemsFoundIndicatorBuilder,
          noMoreItemsIndicatorBuilder: widget.noMoreItemsIndicatorBuilder,
          shrinkWrap: widget.shrinkWrap,
        );
      case CommonStatePaginationType.pagedGridView:
        return CommonStatePaginationBuilder<B, T>.pagedGridView(
          index: widget.index,
          itemBuilder: widget.itemBuilder,
          firstPageErrorIndicatorBuilder: widget.firstPageErrorIndicatorBuilder,
          firstPageProgressIndicatorBuilder:
              widget.firstPageProgressIndicatorBuilder,
          newPageErrorIndicatorBuilder: widget.newPageErrorIndicatorBuilder,
          newPageProgressIndicatorBuilder:
              widget.newPageProgressIndicatorBuilder,
          noItemsFoundIndicatorBuilder: widget.noItemsFoundIndicatorBuilder,
          noMoreItemsIndicatorBuilder: widget.noMoreItemsIndicatorBuilder,
          shrinkWrap: widget.shrinkWrap,
          gridDelegate: widget.gridDelegate,
        );
      case CommonStatePaginationType.pagedSliverList:
        return CommonStatePaginationBuilder<B, T>.pagedSliverList(
          index: widget.index,
          itemBuilder: widget.itemBuilder,
          firstPageErrorIndicatorBuilder: widget.firstPageErrorIndicatorBuilder,
          firstPageProgressIndicatorBuilder:
              widget.firstPageProgressIndicatorBuilder,
          newPageErrorIndicatorBuilder: widget.newPageErrorIndicatorBuilder,
          newPageProgressIndicatorBuilder:
              widget.newPageProgressIndicatorBuilder,
          noItemsFoundIndicatorBuilder: widget.noItemsFoundIndicatorBuilder,
          noMoreItemsIndicatorBuilder: widget.noMoreItemsIndicatorBuilder,
          shrinkWrap: widget.shrinkWrap,
        );
      case CommonStatePaginationType.pagedSliverGrid:
        return CommonStatePaginationBuilder<B, T>.pagedGridView(
          index: widget.index,
          itemBuilder: widget.itemBuilder,
          firstPageErrorIndicatorBuilder: widget.firstPageErrorIndicatorBuilder,
          firstPageProgressIndicatorBuilder:
              widget.firstPageProgressIndicatorBuilder,
          newPageErrorIndicatorBuilder: widget.newPageErrorIndicatorBuilder,
          newPageProgressIndicatorBuilder:
              widget.newPageProgressIndicatorBuilder,
          noItemsFoundIndicatorBuilder: widget.noItemsFoundIndicatorBuilder,
          noMoreItemsIndicatorBuilder: widget.noMoreItemsIndicatorBuilder,
          shrinkWrap: widget.shrinkWrap,
          gridDelegate: widget.gridDelegate,
        );
      default:
        return CommonStatePaginationBuilder<B, T>.pagedPageView(
          index: widget.index,
          itemBuilder: widget.itemBuilder,
          firstPageErrorIndicatorBuilder: widget.firstPageErrorIndicatorBuilder,
          firstPageProgressIndicatorBuilder:
              widget.firstPageProgressIndicatorBuilder,
          newPageErrorIndicatorBuilder: widget.newPageErrorIndicatorBuilder,
          newPageProgressIndicatorBuilder:
              widget.newPageProgressIndicatorBuilder,
          noItemsFoundIndicatorBuilder: widget.noItemsFoundIndicatorBuilder,
          noMoreItemsIndicatorBuilder: widget.noMoreItemsIndicatorBuilder,
          shrinkWrap: widget.shrinkWrap,
        );
    }
  }
}
