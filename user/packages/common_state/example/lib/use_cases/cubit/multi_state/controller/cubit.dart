import 'package:common_state/common_state.dart';
import 'package:example/use_cases/cubit/multi_state/controller/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiStateCubit extends Cubit<MultiStateCubitState> {
  MultiStateCubit() : super(MultiStateCubitState());

  void get() => multiStateApiCall<String>(MultiStateCubitState.state1, () async {
        await Future.delayed(const Duration(seconds: 2));
        return const Right("Multi state Cubit Succeeded");
      });

  void updateData() => emit(state.updateData('state1', 'state1 updated'));
}
