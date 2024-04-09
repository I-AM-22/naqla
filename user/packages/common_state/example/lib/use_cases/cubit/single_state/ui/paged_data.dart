import 'package:example/use_cases/cubit/single_state/controller/single_state_pagination_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../overrides/app_paged_builder.dart';

class PagedData extends StatefulWidget {
  const PagedData({super.key});

  @override
  State<PagedData> createState() => _PagedDataState();
}

class _PagedDataState extends State<PagedData> {
  final cubit = SingleStatePaginationCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: CustomScrollView(
        slivers: [
          AppPagedBuilder<SingleStatePaginationCubit, String>.pagedSliverListView(
            onPageKeyChanged: (value) {
              cubit.fetch(value);
            },
            successWrapper: (pagedWidget) => MultiSliver(
              children: [
                const SliverToBoxAdapter(child: Text('Success wrapper', style: TextStyle(fontSize: 40))),
                pagedWidget,
              ],
            ),
            noItemsFoundIndicatorBuilder: const Text('NOOOO Items found'),
            itemBuilder: (context, item, index) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 203, 155, 233),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 300,
                margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                child: Center(
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
