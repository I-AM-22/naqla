import 'package:common_state/common_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleStateCubit extends Cubit<CommonState<String>> {
  SingleStateCubit() : super(const InitialState());

  void fetch() => apiCall<String>(
        () async {
          await Future.delayed(const Duration(seconds: 2));
          return const Right('Single state cubit succeeded!');
        },
      );
}
