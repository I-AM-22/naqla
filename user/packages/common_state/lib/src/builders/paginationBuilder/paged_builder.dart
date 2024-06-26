import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum PagedWidgetType { pagedListView, pagedGridView, pagedSliverList, pagedSliverGrid, pagedPageView }

class _PagedBuilderState<B extends StateStreamable<BaseState>, T> extends State<PagedBuilder<B, T>> {
  /// The controller that is used to paginate the data
  late final PagingController<int, T> controller;

  /// A flag that indicates if the first page has been loaded
  /// This is useful when you want to show a success wrapper
  bool _firstPageLoaded = false;

  @override
  void initState() {
    super.initState();

    final PaginationState state = _stateSelector(context.read<B>().state);

    controller = state.pagingController as PagingController<int, T>;

    widget.prepare?.call(controller);

    // Add a listener to the controller to show the success wrapper
    if (widget.successWrapper != null) {
      controller.addStatusListener((status) {
        if (status == PagingStatus.ongoing && !_firstPageLoaded) setState(() => _firstPageLoaded = true);
      });
    }

    // Add a listener to the controller to call the onPageKeyChanged callback
    if (widget.onPageKeyChanged != null) {
      controller.addPageRequestListener((pageKey) => widget.onPageKeyChanged!(pageKey));
    }
  }

  /// Builds the pagination widget based on the type
  /// The type is provided by the [widget._type]
  /// The pagination widget is built based on the type
  /// If the type is not supported then it throws an [UnsupportedError]
  Widget _buildPaginationWidget(PagedWidgetType type) {
    switch (type) {
      case PagedWidgetType.pagedGridView:
        return PagedGridView<int, T>(
          shrinkWrap: widget.shrinkWrap,
          pagingController: controller,
          builderDelegate: _builderDelegate,
          gridDelegate: widget.gridDelegate!,
          physics: widget.physics,
          padding: widget.padding,
        );
      case PagedWidgetType.pagedListView:
        if (widget.separatorBuilder != null) {
          return PagedListView<int, T>.separated(
            separatorBuilder: widget.separatorBuilder!,
            padding: widget.padding,
            scrollDirection: widget.scrollDirection ?? Axis.vertical,
            physics: widget.physics,
            pagingController: controller,
            builderDelegate: _builderDelegate,
            shrinkWrap: widget.shrinkWrap,
            itemExtent: widget.itemExtent,
          );
        }
        return PagedListView<int, T>(
          reverse: widget.reverse,
          padding: widget.padding,
          scrollDirection: widget.scrollDirection ?? Axis.vertical,
          physics: widget.physics,
          pagingController: controller,
          builderDelegate: _builderDelegate,
          shrinkWrap: widget.shrinkWrap,
          itemExtent: widget.itemExtent,
        );
      case PagedWidgetType.pagedSliverList:
        if (widget.separatorBuilder != null) {
          return PagedSliverList<int, T>.separated(
            separatorBuilder: widget.separatorBuilder!,
            pagingController: controller,
            builderDelegate: _builderDelegate,
            itemExtent: widget.itemExtent,
          );
        }
        return PagedSliverList<int, T>(
          pagingController: controller,
          builderDelegate: _builderDelegate,
          itemExtent: widget.itemExtent,
        );
      case PagedWidgetType.pagedSliverGrid:
        return PagedSliverGrid<int, T>(
          pagingController: controller,
          builderDelegate: _builderDelegate,
          gridDelegate: widget.gridDelegate!,
        );
      default:
        throw UnsupportedError('Unsupported pagination type');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, BaseState, PaginationState>(
      selector: _stateSelector,
      builder: (context, state) {
        final pagedBuilder = _buildPaginationWidget(widget._type);
        if (_showSuccessWrapper) {
          return widget.successWrapper!(pagedBuilder);
        }
        return pagedBuilder;
      },
    );
  }

  bool get _showSuccessWrapper => _isFirstPage && widget.successWrapper != null;

  bool get _isFirstPage => controller.nextPageKey == controller.firstPageKey + 1;

  /// Converts the [PagedBuilderDelegate] to a [PagedChildBuilderDelegate]
  PagedChildBuilderDelegate<T> get _builderDelegate => PagedChildBuilderDelegate<T>(
        itemBuilder: widget.builderDelegate.itemBuilder,
        firstPageProgressIndicatorBuilder: _builderOrNull(widget.builderDelegate.firstPageProgressIndicatorBuilder),
        newPageProgressIndicatorBuilder: _builderOrNull(widget.builderDelegate.newPageProgressIndicatorBuilder),
        noItemsFoundIndicatorBuilder: _builderOrNull(widget.builderDelegate.noItemsFoundIndicatorBuilder),
        noMoreItemsIndicatorBuilder: _builderOrNull(widget.builderDelegate.noMoreItemsIndicatorBuilder),
        firstPageErrorIndicatorBuilder: widget.builderDelegate.firstPageErrorIndicatorBuilder == null
            ? null
            : (context) => widget.builderDelegate.firstPageErrorIndicatorBuilder!(
                  controller.error,
                  widget.onRetry ?? () => controller.retryLastFailedRequest(),
                ),
        newPageErrorIndicatorBuilder: widget.builderDelegate.newPageErrorIndicatorBuilder == null
            ? null
            : (context) => widget.builderDelegate.newPageErrorIndicatorBuilder!(
                  controller.error,
                  widget.onRetry ?? () => controller.retryLastFailedRequest(),
                ),
      );

  /// converts a widget to a widget builder,handles null widgets
  WidgetBuilder? _builderOrNull(Widget? widget) => widget == null ? null : (context) => widget;

  /// Selects the state from the [BaseState] based on the [stateName]
  /// If the state is not a [StateObject] then it returns the state as is
  /// If the state is a [StateObject] then it selects the state based on the [stateName]
  /// If the [stateName] is not provided and the state is a [StateObject] then it throws an [ArgumentError]
  /// If the selected state is not a [PaginationState] then it throws an [UnsupportedError]
  PaginationState _stateSelector(BaseState state) {
    if (state is! StateObject) {
      if (state is PaginationState) return state;

      throw UnsupportedError('The state is neither a StateObject nor a PaginationState');
    }

    if (widget.stateName == null) {
      throw ArgumentError('The state is of type StateObject but the stateName was not provided');
    }

    final selectedState = state.getState(widget.stateName!);

    if (selectedState is! PaginationState) {
      throw UnsupportedError(
        ''' The selected state (${widget.stateName}) is not a PaginationState of the required type  '''
        '''${state.runtimeType} is not of type PaginationState''',
      );
    }

    return selectedState;
  }
}

/// A paginated builder that listens to the state of a [B] and builds a paginated list
/// [B] is the cubit or bloc that holds the state
/// [T] is the type of the items in the list
class PagedBuilder<B extends StateStreamable<BaseState>, T> extends StatefulWidget {
  /// A constructor that builds a paginated list view
  /// This is useful when you want to build a paginated list
  const PagedBuilder.pagedListView({
    super.key,
    required this.builderDelegate,
    this.stateName,
    this.separatorBuilder,
    this.onPageKeyChanged,
    this.padding,
    this.scrollDirection,
    this.physics,
    this.shrinkWrap = false,
    this.prepare,
    this.successWrapper,
    this.onRetry,
    this.itemExtent,
    this.reverse = false,
  })  : _type = PagedWidgetType.pagedListView,
        gridDelegate = null;

  /// A constructor that builds a paginated grid view
  /// This is useful when you want to build a paginated grid
  const PagedBuilder.pagedGridView({
    super.key,
    required this.builderDelegate,
    required this.gridDelegate,
    this.stateName,
    this.onPageKeyChanged,
    this.padding,
    this.scrollDirection,
    this.physics,
    this.shrinkWrap = false,
    this.prepare,
    this.successWrapper,
    this.onRetry,
    this.itemExtent,
    this.reverse = false,
  })  : _type = PagedWidgetType.pagedGridView,
        separatorBuilder = null;

  /// A constructor that builds a paginated sliver list
  /// This is useful when you want to build a paginated list in a sliver
  const PagedBuilder.pagedSliverList({
    super.key,
    required this.builderDelegate,
    this.stateName,
    this.separatorBuilder,
    this.onPageKeyChanged,
    this.padding,
    this.scrollDirection,
    this.physics,
    this.shrinkWrap = false,
    this.prepare,
    this.successWrapper,
    this.onRetry,
    this.itemExtent,
    this.reverse = false,
  })  : _type = PagedWidgetType.pagedSliverList,
        gridDelegate = null;

  /// A constructor that builds a paginated sliver grid
  /// This is useful when you want to build a paginated grid in a sliver
  const PagedBuilder.pagedSliverGrid({
    super.key,
    required this.builderDelegate,
    required this.gridDelegate,
    this.stateName,
    this.onPageKeyChanged,
    this.padding,
    this.scrollDirection,
    this.physics,
    this.shrinkWrap = false,
    this.prepare,
    this.successWrapper,
    this.onRetry,
    this.itemExtent,
    this.reverse = false,
  })  : _type = PagedWidgetType.pagedSliverGrid,
        separatorBuilder = null;

  /// A constructor that builds a paginated page view
  /// This is useful when you want to build a paginated page view
  const PagedBuilder.pagedPageView({
    super.key,
    required this.builderDelegate,
    this.stateName,
    this.separatorBuilder,
    this.onPageKeyChanged,
    this.padding,
    this.scrollDirection,
    this.physics,
    this.shrinkWrap = false,
    this.prepare,
    this.successWrapper,
    this.onRetry,
    this.itemExtent,
    this.reverse = false,
  })  : _type = PagedWidgetType.pagedPageView,
        gridDelegate = null;

  final PagedWidgetType _type;

  /// The builder delegate that builds the paginated list
  /// This is a substitute for the [PagedChildBuilderDelegate]
  final PagedBuilderDelegate<T> builderDelegate;

  final bool shrinkWrap;
  final Axis? scrollDirection;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final SliverGridDelegate? gridDelegate;
  final IndexedWidgetBuilder? separatorBuilder;
  final double? itemExtent;
  final bool reverse;

  /// The name of the state that holds the paginated data
  /// This is useful when the state is a [StateObject] and you want to select a specific state
  /// The default value is null
  final String? stateName;

  /// A callback that is called when the page key changes
  /// This is useful when you want to fetch the next page
  /// this is a substitute for the [PagingController.addPageRequestListener]
  final ValueChanged<int>? onPageKeyChanged;

  /// A callback that is called when the user clicks the retry button
  /// This is useful when you want to retry the last failed request
  /// The default value of that is [controller.retryLastFailedRequest]
  final VoidCallback? onRetry;

  /// A callback that is called before the controller is used
  final void Function(PagingController<int, T> controller)? prepare;

  /// A wrapper that wraps the paginated widget
  /// This is useful when you want to add a header or footer to the paginated widget
  final Widget Function(Widget pagedWidget)? successWrapper;

  //region mjhbjbjb
// endRegion
  @override
  State<PagedBuilder<B, T>> createState() => _PagedBuilderState<B, T>();
}
