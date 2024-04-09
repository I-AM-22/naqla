import 'package:common_state/common_state.dart';


class MultiStateCubitState extends StateObject<MultiStateCubitState> {
  static const String state1 = 'state1';
  static const String state2 = 'state2';
  static const String state3 = 'state3';

  MultiStateCubitState([States? states])
      : super(
          [
            const InitialState<String>(state1),
            const InitialState<int>(state2),
            PaginationState(state3),
          ],
          (states) => MultiStateCubitState(states),
          states,
        );
}
