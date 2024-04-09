import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/utils.dart';
import '../../../../overrides/app_paged_builder.dart';
import '../controller/bloc.dart';

class PagedData extends StatefulWidget {
  const PagedData({super.key});

  @override
  State<PagedData> createState() => _PagedDataState();
}

class _PagedDataState extends State<PagedData> {
  @override
  void initState() {
    context.read<MultiStateBloc>()
      ..add(FetchPagination(pageKey: 0))
      ..add(UpdateSomeProperty(true))
      ..add(UpdateExampleProperty(const ExampleProperty(2, true)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return AppPagedBuilder<MultiStateBloc, String>.pagedListView(
        stateName: 'state3Pagination',
        onPageKeyChanged: (value) {
          context.read<MultiStateBloc>().add(FetchPagination(pageKey: value));
        },
        prepare: (controller) => controller.appendPage(['appended on init', 'appended on init'], 1),
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
      );
    });
  }
}
