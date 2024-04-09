// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc.dart';

@immutable
class MultiStateBlocState extends StateObject<MultiStateBlocState> {
  final bool? someProperty;
  final ExampleProperty? exampleProperty;

  MultiStateBlocState([
    States? states,
    this.someProperty,
    this.exampleProperty,
  ]) : super(
          [
            const InitialState<String>('state1'),
            const InitialState<int>('state2'),
            PaginationState<SomPaginatedData, String>('state3Pagination')
          ],
          (states) => MultiStateBlocState(states, someProperty, exampleProperty),
          states,
        );

  MultiStateBlocState copyWith({bool? someProperty, ExampleProperty? exampleProperty}) => MultiStateBlocState(
        states,
        someProperty ?? this.someProperty,
        exampleProperty ?? this.exampleProperty,
      );

  @override
  List<Object?> get props => [states, someProperty, exampleProperty];
}
