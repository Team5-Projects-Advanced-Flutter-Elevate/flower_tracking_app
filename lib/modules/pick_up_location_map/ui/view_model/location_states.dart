import 'package:equatable/equatable.dart';

enum Status { idle, loading, success, error }

class LocationStates extends Equatable {
  final Status requestLocationPermissionStatus;
  final Status getCurrentUserLocationStatus;
  final Status getDirectionBetweenPointsStatus;
  final Object? error;

  const LocationStates({
    this.requestLocationPermissionStatus = Status.idle,
    this.getCurrentUserLocationStatus = Status.idle,
    this.getDirectionBetweenPointsStatus = Status.idle,
    this.error,
  });

  LocationStates copyWith({
    Status? requestLocationPermissionStatus,
    Status? getCurrentUserLocationStatus,
    Status? getDirectionBetweenPointsStatus,
    Object? error,
  }) {
    return LocationStates(
      requestLocationPermissionStatus:
          requestLocationPermissionStatus ??
          this.requestLocationPermissionStatus,
      getCurrentUserLocationStatus:
          getCurrentUserLocationStatus ?? this.getCurrentUserLocationStatus,
      getDirectionBetweenPointsStatus:
          getDirectionBetweenPointsStatus ??
          this.getDirectionBetweenPointsStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    requestLocationPermissionStatus,
    getCurrentUserLocationStatus,
    getDirectionBetweenPointsStatus,
    error,
  ];
}
