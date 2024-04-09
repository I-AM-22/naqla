import 'package:example/overrides/app_result_builder.dart';
import 'package:example/use_cases/cubit/multi_state/controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/state.dart';

class MultiStateCubitPage extends StatefulWidget {
  const MultiStateCubitPage({super.key});

  @override
  State<MultiStateCubitPage> createState() => _MultiStateCubitPageState();
}

class _MultiStateCubitPageState extends State<MultiStateCubitPage> {
  final cubit = MultiStateCubit();
  @override
  void initState() {
    _updateDataAfter10Second();
    super.initState();
  }

  void _updateDataAfter10Second() {
    Future.delayed(const Duration(seconds: 10), () {
      cubit.updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..get(),
      child: Scaffold(
        body: Center(
          child: AppResultBuilder<MultiStateCubit, String>(
            stateName: MultiStateCubitState.state1,
            loaded: (data) => Text(data, style: const TextStyle(fontSize: 30)),
          ),
        ),
      ),
    );
  }
}
