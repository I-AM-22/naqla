export 'bloc_extension.dart';
export 'cubit_extension.dart';

extension MapExtension<K, V> on Map<K, V> {
  Map<int, V> setState(int index, V newState) => Map<int, V>.from(this)..[index] = newState;
}
