import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';
// import 'package:flutter_native_admob/flutter_native_admob.dart';

import 'package:shimmer/shimmer.dart';

class TaskersListing extends StatefulWidget {
  const TaskersListing({
    super.key,
    this.showSelect = false,
    this.isScrollable = false,
    this.minItems = 8,
    required this.taskers,
    this.onScroll,
    required this.hasReachedMax,
    this.loadMoreScrollExtend = 0.8,
    this.padding,
    this.showVehicleItemActivationStatusBar = false,
  });

  final bool showSelect;
  final bool isScrollable;
  final int minItems;
  final List<User> taskers;
  final void Function()? onScroll;
  final bool hasReachedMax;
  final double loadMoreScrollExtend;
  final EdgeInsets? padding;
  final bool showVehicleItemActivationStatusBar;

  @override
  State<TaskersListing> createState() => _TaskersListingState();
}

class _TaskersListingState extends State<TaskersListing> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return widget.taskers.isEmpty
        ? Center(
            child: FetchEmpty(
              message: trans(context)!.no_tasker_found,
            ),
          )
        : ListView.separated(
            padding: widget.padding,
            itemBuilder: (context, index) {
              final user = widget.taskers[index];

              final taskerItem = TaskerItem(
                showSelect: widget.showSelect,
                user: user,
              );
              return widget.isScrollable
                  ? (index >= widget.taskers.length
                      ? LoadingIndicator()
                      : taskerItem)
                  : taskerItem;
            },
            controller: widget.isScrollable ? _scrollController : null,
            separatorBuilder: (context, index) {
              return 2.h.ph;
            },
            itemCount: widget.isScrollable
                ? (widget.hasReachedMax
                    ? widget.taskers.length
                    : widget.taskers.length + 1)
                : (widget.taskers.length >= widget.minItems
                    ? widget.minItems
                    : widget.taskers.length),
            physics: widget.isScrollable
                ? null
                : const NeverScrollableScrollPhysics(),
            shrinkWrap: widget.isScrollable == false ? true : false,
          );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      if (widget.onScroll != null) {
        widget.onScroll!();
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * widget.loadMoreScrollExtend);
  }
}
