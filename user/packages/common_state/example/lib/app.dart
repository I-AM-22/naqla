import 'package:example/use_cases/bloc/multi_state/ui/multi_state_bloc_page.dart';
import 'package:example/use_cases/cubit/single_state/ui/single_state_cubit_page.dart';
import 'package:flutter/material.dart';

import 'use_cases/cubit/multi_state/ui/multi_state_cubit_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: true,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.signal_cellular_0_bar_outlined),
                  label: Text('Multi state bloc', style: TextStyle(fontSize: 15)),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.square_outlined),
                  label: Text('Single state cubit', style: TextStyle(fontSize: 15)),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.circle_outlined),
                  label: Text('Multi state cubit', style: TextStyle(fontSize: 15)),
                )
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: (value) => setState(() => _selectedIndex = value),
            ),
            Expanded(
                child: IndexedStack(
              index: _selectedIndex,
              children: const [
                MultiStateBlocPage(),
                SingleStateCubitPage(),
                MultiStateCubitPage(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
