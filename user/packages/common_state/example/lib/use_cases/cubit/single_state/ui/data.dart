import 'package:example/overrides/app_result_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/single_state_cubit.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  final cubit = SingleStateCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..fetch(),
      child: Scaffold(
        body: Center(
          child: AppResultBuilder<SingleStateCubit, String>(
            loaded: (data) {
              return Text(data, style: const TextStyle(fontSize: 30));
            },
          ),
        ),
      ),
    );
  }
}
