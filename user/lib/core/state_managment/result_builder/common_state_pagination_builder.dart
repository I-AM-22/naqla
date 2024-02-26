import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:naqla/core/global_widgets/app_text.dart';
import 'package:naqla/core/state_managment/state/common_state.dart';

/// B is Bloc
/// T is Enum and should extends from Helper
/// D is data
/// [Example ] CommonStateBuilder<HomeBloc>(state: TestState.getProduct),
enum CommonStatePaginationType {
  pagedListView,
  pagedGridView,
  pagedSliverList,
  pagedSliverGrid,
  pagedPageView
}

class CommonStatePaginationBuilder<
    B extends StateStreamable<Map<int, CommonState>>,
    T> extends StatelessWidget {
  const CommonStatePaginationBuilder.pagedListView({
    super.key,
    required this.index,
    required this.itemBuilder,
    required this.firstPageErrorIndicatorBuilder,
    required this.firstPageProgressIndicatorBuilder,
    required this.newPageErrorIndicatorBuilder,
    required this.newPageProgressIndicatorBuilder,
    required this.noItemsFoundIndicatorBuilder,
    required this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.shrinkWrap = false,
  })  : _type = CommonStatePaginationType.pagedListView,
        gridDelegate = null;

  const CommonStatePaginationBuilder.pagedGridView({
    super.key,
    required this.index,
    required this.itemBuilder,
    required this.firstPageErrorIndicatorBuilder,
    required this.firstPageProgressIndicatorBuilder,
    required this.newPageErrorIndicatorBuilder,
    required this.newPageProgressIndicatorBuilder,
    required this.noItemsFoundIndicatorBuilder,
    required this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.shrinkWrap = false,
    this.gridDelegate,
  }) : _type = CommonStatePaginationType.pagedGridView;

  const CommonStatePaginationBuilder.pagedSliverList({
    super.key,
    required this.index,
    required this.itemBuilder,
    required this.firstPageErrorIndicatorBuilder,
    required this.firstPageProgressIndicatorBuilder,
    required this.newPageErrorIndicatorBuilder,
    required this.newPageProgressIndicatorBuilder,
    required this.noItemsFoundIndicatorBuilder,
    required this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.shrinkWrap = false,
  })  : _type = CommonStatePaginationType.pagedSliverList,
        gridDelegate = null;

  const CommonStatePaginationBuilder.pagedSliverGrid({
    super.key,
    required this.index,
    required this.itemBuilder,
    required this.firstPageErrorIndicatorBuilder,
    required this.firstPageProgressIndicatorBuilder,
    required this.newPageErrorIndicatorBuilder,
    required this.newPageProgressIndicatorBuilder,
    required this.noItemsFoundIndicatorBuilder,
    required this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.shrinkWrap = false,
    this.gridDelegate,
  }) : _type = CommonStatePaginationType.pagedSliverGrid;

  const CommonStatePaginationBuilder.pagedPageView({
    super.key,
    required this.index,
    required this.itemBuilder,
    required this.firstPageErrorIndicatorBuilder,
    required this.firstPageProgressIndicatorBuilder,
    required this.newPageErrorIndicatorBuilder,
    required this.newPageProgressIndicatorBuilder,
    required this.noItemsFoundIndicatorBuilder,
    required this.noMoreItemsIndicatorBuilder,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.shrinkWrap = false,
  })  : _type = CommonStatePaginationType.pagedPageView,
        gridDelegate = null;

  final int index;
  final bool shrinkWrap;

  final ItemWidgetBuilder<T> itemBuilder;
  final Widget? firstPageErrorIndicatorBuilder;
  final Widget? firstPageProgressIndicatorBuilder;
  final Widget? newPageErrorIndicatorBuilder;
  final Widget? newPageProgressIndicatorBuilder;
  final Widget? noItemsFoundIndicatorBuilder;
  final Widget? noMoreItemsIndicatorBuilder;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final CommonStatePaginationType _type;
  final SliverGridDelegate? gridDelegate;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, Map<int, CommonState>, CommonState>(
      selector: (state) => state[index]!,
      builder: (context, state) {
        if (state is PaginationClass) {
          switch (_type) {
            case CommonStatePaginationType.pagedGridView:
              return PagedGridView<int, T>(
                shrinkWrap: shrinkWrap,
                pagingController:
                    (state).pagingController as PagingController<int, T>,
                builderDelegate: PagedChildBuilderDelegate<T>(
                    itemBuilder: itemBuilder,
                    firstPageErrorIndicatorBuilder:
                        firstPageErrorIndicatorBuilder != null
                            ? (context) => firstPageErrorIndicatorBuilder!
                            : null,
                    firstPageProgressIndicatorBuilder:
                        firstPageProgressIndicatorBuilder != null
                            ? ((context) => firstPageProgressIndicatorBuilder!)
                            : null,
                    newPageErrorIndicatorBuilder:
                        newPageErrorIndicatorBuilder != null
                            ? ((context) => newPageErrorIndicatorBuilder!)
                            : null,
                    newPageProgressIndicatorBuilder:
                        newPageProgressIndicatorBuilder != null
                            ? ((context) => newPageProgressIndicatorBuilder!)
                            : null,
                    noItemsFoundIndicatorBuilder:
                        noItemsFoundIndicatorBuilder != null
                            ? ((context) => noItemsFoundIndicatorBuilder!)
                            : null,
                    noMoreItemsIndicatorBuilder:
                        noMoreItemsIndicatorBuilder != null
                            ? ((context) => noMoreItemsIndicatorBuilder!)
                            : null),
                gridDelegate: gridDelegate ??
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.w,
                    ),
              );
            case CommonStatePaginationType.pagedListView:
              return PagedListView<int, T>(
                shrinkWrap: shrinkWrap,
                padding: padding,
                scrollDirection: scrollDirection,
                physics: physics,
                pagingController:
                    (state).pagingController as PagingController<int, T>,
                builderDelegate: PagedChildBuilderDelegate<T>(
                    itemBuilder: itemBuilder,
                    firstPageErrorIndicatorBuilder:
                        firstPageErrorIndicatorBuilder != null
                            ? (context) => firstPageErrorIndicatorBuilder!
                            : null,
                    firstPageProgressIndicatorBuilder:
                        firstPageProgressIndicatorBuilder != null
                            ? ((context) => firstPageProgressIndicatorBuilder!)
                            : null,
                    newPageErrorIndicatorBuilder:
                        newPageErrorIndicatorBuilder != null
                            ? ((context) => newPageErrorIndicatorBuilder!)
                            : null,
                    newPageProgressIndicatorBuilder:
                        newPageProgressIndicatorBuilder != null
                            ? ((context) => newPageProgressIndicatorBuilder!)
                            : null,
                    noItemsFoundIndicatorBuilder:
                        noItemsFoundIndicatorBuilder != null
                            ? ((context) => noItemsFoundIndicatorBuilder!)
                            : null,
                    noMoreItemsIndicatorBuilder:
                        noMoreItemsIndicatorBuilder != null
                            ? ((context) => noMoreItemsIndicatorBuilder!)
                            : null),
              );
            case CommonStatePaginationType.pagedSliverList:
              return PagedSliverList(
                shrinkWrapFirstPageIndicators: shrinkWrap,
                pagingController:
                    (state).pagingController as PagingController<int, T>,
                builderDelegate: PagedChildBuilderDelegate<T>(
                    itemBuilder: itemBuilder,
                    firstPageErrorIndicatorBuilder:
                        firstPageErrorIndicatorBuilder != null
                            ? (context) => firstPageErrorIndicatorBuilder!
                            : null,
                    firstPageProgressIndicatorBuilder:
                        firstPageProgressIndicatorBuilder != null
                            ? ((context) => firstPageProgressIndicatorBuilder!)
                            : null,
                    newPageErrorIndicatorBuilder:
                        newPageErrorIndicatorBuilder != null
                            ? ((context) => newPageErrorIndicatorBuilder!)
                            : null,
                    newPageProgressIndicatorBuilder:
                        newPageProgressIndicatorBuilder != null
                            ? ((context) => newPageProgressIndicatorBuilder!)
                            : null,
                    noItemsFoundIndicatorBuilder:
                        noItemsFoundIndicatorBuilder != null
                            ? ((context) => noItemsFoundIndicatorBuilder!)
                            : null,
                    noMoreItemsIndicatorBuilder:
                        noMoreItemsIndicatorBuilder != null
                            ? ((context) => noMoreItemsIndicatorBuilder!)
                            : null),
              );

            case CommonStatePaginationType.pagedSliverGrid:
              return PagedSliverGrid<int, T>(
                shrinkWrapFirstPageIndicators: shrinkWrap,
                pagingController:
                    (state).pagingController as PagingController<int, T>,
                builderDelegate: PagedChildBuilderDelegate<T>(
                    itemBuilder: itemBuilder,
                    firstPageErrorIndicatorBuilder:
                        firstPageErrorIndicatorBuilder != null
                            ? (context) => firstPageErrorIndicatorBuilder!
                            : null,
                    firstPageProgressIndicatorBuilder:
                        firstPageProgressIndicatorBuilder != null
                            ? ((context) => firstPageProgressIndicatorBuilder!)
                            : null,
                    newPageErrorIndicatorBuilder:
                        newPageErrorIndicatorBuilder != null
                            ? ((context) => newPageErrorIndicatorBuilder!)
                            : null,
                    newPageProgressIndicatorBuilder:
                        newPageProgressIndicatorBuilder != null
                            ? ((context) => newPageProgressIndicatorBuilder!)
                            : null,
                    noItemsFoundIndicatorBuilder:
                        noItemsFoundIndicatorBuilder != null
                            ? ((context) => noItemsFoundIndicatorBuilder!)
                            : null,
                    noMoreItemsIndicatorBuilder:
                        noMoreItemsIndicatorBuilder != null
                            ? ((context) => noMoreItemsIndicatorBuilder!)
                            : null),
                gridDelegate: gridDelegate ??
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.w,
                    ),
              );
            default:
              return PagedPageView<int, T>(
                shrinkWrapFirstPageIndicators: shrinkWrap,
                scrollDirection: scrollDirection,
                physics: physics,
                pagingController:
                    (state).pagingController as PagingController<int, T>,
                builderDelegate: PagedChildBuilderDelegate<T>(
                    itemBuilder: itemBuilder,
                    firstPageErrorIndicatorBuilder:
                        firstPageErrorIndicatorBuilder != null
                            ? (context) => firstPageErrorIndicatorBuilder!
                            : null,
                    firstPageProgressIndicatorBuilder:
                        firstPageProgressIndicatorBuilder != null
                            ? ((context) => firstPageProgressIndicatorBuilder!)
                            : null,
                    newPageErrorIndicatorBuilder:
                        newPageErrorIndicatorBuilder != null
                            ? ((context) => newPageErrorIndicatorBuilder!)
                            : null,
                    newPageProgressIndicatorBuilder:
                        newPageProgressIndicatorBuilder != null
                            ? ((context) => newPageProgressIndicatorBuilder!)
                            : null,
                    noItemsFoundIndicatorBuilder:
                        noItemsFoundIndicatorBuilder != null
                            ? ((context) => noItemsFoundIndicatorBuilder!)
                            : null,
                    noMoreItemsIndicatorBuilder:
                        noMoreItemsIndicatorBuilder != null
                            ? ((context) => noMoreItemsIndicatorBuilder!)
                            : null),
              );
          }
        }
        return SizedBox(
          child: AppText("dsadas"),
        );
      },
    );
  }
}
