import 'package:flutter/material.dart';

import 'data.dart';
import 'paged_data.dart';

class SingleStateCubitPage extends StatelessWidget {
  const SingleStateCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
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
                  Center(child: Data()),
                  Center(child: PagedData()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
