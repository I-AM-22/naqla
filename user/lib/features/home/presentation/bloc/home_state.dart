part of 'home_bloc.dart';

@immutable
class HomeState {
  final PageState<Iterable<Polyline>> polylineState;
  final PointLatLng? currentLocation;
  final PointLatLng? lastDestination;
  final String? lastOrderNumber;
  final Marker? currentDestination;
  final Marker? currentOrigin;

  const HomeState(
      {this.currentLocation,
      this.lastDestination,
      this.lastOrderNumber,
      this.currentDestination,
      this.currentOrigin,
      required this.polylineState});

  HomeState copyWith(
      {PointLatLng? currentLocation,
      PointLatLng? lastDestination,
      String? lastOrderNumber,
      final Marker? currentDestination,
      final Marker? currentOrigin,
      final PageState<Iterable<Polyline>>? polylineState}) {
    return HomeState(
        currentLocation: currentLocation ?? this.currentLocation,
        lastDestination: lastDestination ?? this.lastDestination,
        lastOrderNumber: lastOrderNumber ?? this.lastOrderNumber,
        currentDestination: currentDestination ?? this.currentDestination,
        currentOrigin: currentOrigin ?? this.currentOrigin,
        polylineState: polylineState ?? this.polylineState);
  }
}
