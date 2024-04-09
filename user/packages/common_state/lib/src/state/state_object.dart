// ignore_for_file: body_might_complete_normally_nullable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../common_state.dart';
import '../types.dart';

/// An abstract class representing common states of an object.
///
/// This class provides a base for concrete state objects. Extend this class
/// and provide your class type as the generic type parameter.
///
/// Example usage:
///
/// ```dart
/// class MyStateObject extends StateObject<MyStateObject> {
///   MyStateObject([States? states]) : super(
///     [
///       const InitialState('state1'),
///       const PaginationState('state2'),
///     ],
///     (states) => MyStateObject(states),
///     states,
///   );
/// }
/// ```
@immutable
abstract class StateObject<T> extends BaseState with EquatableMixin {
  /// The initial state
  final List<CommonState> initial;

  /// the variable that contains all the state object [CommonState]
  final Map<String, CommonState> states;

  /// Used to create a new instance of [T] with the new state
  final InstanceCreator<T> instanceCreator;

  StateObject(this.initial, this.instanceCreator, [States? states]) : states = states ?? _mapStates(initial) {
    if (T == dynamic) {
      throw ArgumentError('Type argument T cannot be dynamic. Please provide a specific type.');
    }

    if (initial.map((e) => e.name).contains(null)) {
      throw ArgumentError('Please specify all state names, no state name can be null.');
    }

    if (_containsDuplicates(initial.map((e) => e.name!))) {
      throw ArgumentError('State names cannot contain duplicates. Please provide unique state names.');
    }
  }

  /// Update the selected state
  T updateState(String name, CommonState newState) {
    if (states[name] == null) {
      throw Exception('state $name could not be found');
    }

    return instanceCreator(_updatedState(name, newState));
  }

  /// returns the state corresponding to [name], throws [ArgumentError] if no state with that name exists
  CommonState<S> getState<S>(String name) {
    CommonState<S>? state = states[name] as CommonState<S>?;

    if (state == null) {
      throw ArgumentError('The state ($name) could not be found, please check the state name');
    }

    return state;
  }

  /// updates the selected state data, throws [UnsupportedError] if the selected state is not a [SuccessState<T>]
  T updateData<D>(String stateName, D updatedData) {
    final selectedState = getState(stateName);
    if (selectedState is! SuccessState && selectedState is! EmptyState) {
      throw UnsupportedError(
        'Tried calling updateSuccessState on non SuccessState,  $runtimeType is not SuccessState nor EmptyState',
      );
    }

    return instanceCreator(_updatedState(stateName, SuccessState<D>(updatedData)));
  }

  @override
  List<Object?> get props => [states];

  //================================================================== Inner utils ==================================================================

  States _updatedState(String name, CommonState newState) {
    final updatedMap = Map<String, CommonState>.from(states);
    updatedMap[name] = newState;
    return updatedMap;
  }

  static States _mapStates(List<CommonState> statesList) {
    return statesList.fold(
      {},
      (map, initial) {
        if (initial.name == null || initial.name!.isEmpty) {
          throw Exception('initial state names cannot be null nor empty, please provide a valid name');
        }

        final String stateName = initial.name!;

        map[stateName] = initial;
        return map;
      },
    );
  }

  static bool _containsDuplicates(Iterable<String> names) => names.toSet().length != names.length;
}
