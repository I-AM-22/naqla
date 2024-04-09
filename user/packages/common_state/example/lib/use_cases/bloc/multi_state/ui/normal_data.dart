import 'package:flutter/material.dart';

import '../../../../overrides/app_result_builder.dart';
import '../controller/bloc.dart';

class NormalData extends StatelessWidget {
  const NormalData({super.key});

  @override
  Widget build(BuildContext context) {
    return AppResultBuilder<MultiStateBloc, String>(
      stateName: 'state1',
      loaded: (data) => Text(data, style: const TextStyle(fontSize: 30)),
    );
  } //
}
