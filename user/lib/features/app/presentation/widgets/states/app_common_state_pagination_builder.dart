import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:naqla/core/core.dart';

import '../app_loading_indicator.dart';
import 'error_page.dart';

class AppPagedBuilder<B extends StateStreamable<StateObject>, T> extends StatelessWidget {
  final String stateName;
  final PagedWidgetType _type;

  final ItemWidgetBuilder<T> itemBuilder;
  final Widget Function(dynamic error, VoidCallback voidCallback)? firstPageErrorIndicatorBuilder;
  final Widget Function(dynamic error, VoidCallback voidCallback)? newPageErrorIndicatorBuilder;
  final void Function()? onEmptyPressed;
  final void Function()? onErrorPressed;
  final Widget? firstPageProgressIndicatorBuilder;
  final Widget? newPageProgressIndicatorBuilder;
  final Widget? noItemsFoundIndicatorBuilder;
  final Widget? noMoreItemsIndicatorBuilder;
  final EdgeInsetsGeometry? padding;
  final SliverGridDelegate? gridDelegate;
  final bool reverse;
  final void Function(PagingController<int, T>)? prepare;

  final Axis? scrollDirection;

  final ScrollPhysics? physics;
  final bool? shrinkWrap;

  ///this is not required and when pass it null you should add paternalist in initState
  final ValueChanged<int>? onPageKeyChanged;
  final IndexedWidgetBuilder? separatorBuilder;

  const AppPagedBuilder.pagedListView({
    super.key,
    required this.itemBuilder,
    required this.stateName,
    required this.onPageKeyChanged,
    this.firstPageErrorIndicatorBuilder,
    this.separatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection,
    this.physics,
    this.gridDelegate,
    this.shrinkWrap,
    this.prepare,
    this.onEmptyPressed,
    this.onErrorPressed,
    this.reverse = false,
  }) : _type = PagedWidgetType.pagedListView;

  const AppPagedBuilder.pagedGridView({
    super.key,
    required this.itemBuilder,
    required this.stateName,
    required this.onPageKeyChanged,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection,
    this.physics,
    this.gridDelegate,
    this.shrinkWrap,
    this.prepare,
    this.onEmptyPressed,
    this.onErrorPressed,
    this.reverse = false,
  })  : _type = PagedWidgetType.pagedGridView,
        separatorBuilder = null;

  const AppPagedBuilder.pagedSliverListView({
    super.key,
    required this.itemBuilder,
    required this.stateName,
    required this.onPageKeyChanged,
    this.firstPageErrorIndicatorBuilder,
    this.separatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection,
    this.physics,
    this.shrinkWrap,
    this.prepare,
    this.onEmptyPressed,
    this.onErrorPressed,
    this.reverse = false,
  })  : _type = PagedWidgetType.pagedSliverList,
        gridDelegate = null;

  const AppPagedBuilder.pagedSliverGridView({
    super.key,
    required this.itemBuilder,
    required this.stateName,
    required this.onPageKeyChanged,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection,
    this.physics,
    this.gridDelegate,
    this.shrinkWrap,
    this.prepare,
    this.onEmptyPressed,
    this.onErrorPressed,
    this.reverse = false,
  })  : _type = PagedWidgetType.pagedSliverGrid,
        separatorBuilder = null;

  const AppPagedBuilder.pagedPageView({
    super.key,
    required this.onPageKeyChanged,
    required this.itemBuilder,
    required this.stateName,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.separatorBuilder,
    this.padding,
    this.scrollDirection,
    this.physics,
    this.shrinkWrap,
    this.prepare,
    this.onEmptyPressed,
    this.onErrorPressed,
    this.reverse = false,
  })  : _type = PagedWidgetType.pagedPageView,
        gridDelegate = null;

  Widget _buildPaginationWidget(PagedWidgetType type) {
    final commonStateBuilderDelegate = PagedBuilderDelegate<T>(
      itemBuilder: itemBuilder,
      firstPageErrorIndicatorBuilder: firstPageErrorIndicatorBuilder ?? (error, voidCallback) => const ErrorPage(),
      firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder ?? const AppLoadingIndicator(),
      newPageErrorIndicatorBuilder: newPageErrorIndicatorBuilder ?? (error, voidCallBack) => Text(error),
      newPageProgressIndicatorBuilder: newPageProgressIndicatorBuilder ?? const AppLoadingIndicator(),
      noMoreItemsIndicatorBuilder: noMoreItemsIndicatorBuilder ?? const SizedBox.shrink(),
      noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder ??
          Center(
            child: AppText('لا يوجد بيانات لعرضها'),
          ),
    );

    switch (type) {
      case PagedWidgetType.pagedGridView:
        return PagedBuilder<B, T>.pagedGridView(
          reverse: reverse,
          stateName: stateName,
          builderDelegate: commonStateBuilderDelegate,
          onPageKeyChanged: onPageKeyChanged,
          padding: padding,
          physics: physics,
          scrollDirection: scrollDirection,
          shrinkWrap: shrinkWrap ?? false,
          prepare: prepare,
          gridDelegate: gridDelegate ??
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.w,
              ),
        );
      case PagedWidgetType.pagedListView:
        if (separatorBuilder != null) {
          return PagedBuilder<B, T>.pagedListView(
            prepare: prepare,
            reverse: reverse,
            separatorBuilder: separatorBuilder!,
            stateName: stateName,
            padding: padding,
            physics: physics,
            builderDelegate: commonStateBuilderDelegate,
            onPageKeyChanged: onPageKeyChanged,
            scrollDirection: scrollDirection,
            shrinkWrap: shrinkWrap ?? false,
          );
        }
        return PagedBuilder<B, T>.pagedListView(
          prepare: prepare,
          reverse: reverse,
          padding: padding,
          stateName: stateName,
          physics: physics,
          builderDelegate: commonStateBuilderDelegate,
          onPageKeyChanged: onPageKeyChanged,
          scrollDirection: scrollDirection,
          shrinkWrap: shrinkWrap ?? false,
        );
      case PagedWidgetType.pagedSliverList:
        if (separatorBuilder != null) {
          return PagedBuilder<B, T>.pagedSliverList(
            prepare: prepare,
            reverse: reverse,
            stateName: stateName,
            separatorBuilder: separatorBuilder!,
            builderDelegate: commonStateBuilderDelegate,
            onPageKeyChanged: onPageKeyChanged,
            padding: padding,
            physics: physics,
            scrollDirection: scrollDirection,
            shrinkWrap: shrinkWrap ?? false,
          );
        }
        return PagedBuilder<B, T>.pagedSliverList(
          prepare: prepare,
          reverse: reverse,
          stateName: stateName,
          builderDelegate: commonStateBuilderDelegate,
          shrinkWrap: shrinkWrap ?? false,
        );
      case PagedWidgetType.pagedSliverGrid:
        return PagedBuilder<B, T>.pagedSliverGrid(
          prepare: prepare,
          stateName: stateName,
          reverse: reverse,
          onPageKeyChanged: onPageKeyChanged,
          padding: padding,
          physics: physics,
          scrollDirection: scrollDirection,
          builderDelegate: commonStateBuilderDelegate,
          shrinkWrap: shrinkWrap ?? false,
          gridDelegate: gridDelegate ??
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.w,
              ),
        );
      default:
        throw Exception('Unsupported pagination type');
    }
  }

  @override
  Widget build(BuildContext context) => _buildPaginationWidget(_type);
}
