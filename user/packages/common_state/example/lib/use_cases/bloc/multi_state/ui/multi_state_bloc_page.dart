import 'package:example/use_cases/bloc/multi_state/ui/normal_data.dart';
import 'package:example/use_cases/bloc/multi_state/ui/paged_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/bloc.dart';

class MultiStateBlocPage extends StatelessWidget {
  const MultiStateBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MultiStateBloc()..add(Fetch()),
      child: const DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              TabBar(tabs: [
                Tab(text: 'Normal data'),
                Tab(text: 'Paged data'),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: NormalData()),
                    Center(child: PagedData()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
