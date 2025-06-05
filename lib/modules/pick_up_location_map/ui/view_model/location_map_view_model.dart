import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/core/utilities/bloc_observer/location_permission_denied.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/domain/entities/directions_request/directions_request_entity.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/domain/entities/directions_response/directions_response_entity.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/domain/use_cases/directions/get_directions_use_case.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/ui/view_model/location_states.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/ui/widgets/marker_child_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';

@injectable
class LocationMapViewModel extends Cubit<LocationStates> {
  final GetDirectionsUseCase _getDirectionsUseCase;

  LocationMapViewModel(this._getDirectionsUseCase)
    : super(const LocationStates());
  final MapController mapController = MapController();
  LocationData? currentLocation;
  List<LatLng> routePoints = [];
  List<Marker> markers = [];

  final Location _location = Location();

  late ValueNotifier<LocationData> newLocationNotifier;

  void doIntent(LocationMapIntent intent) {
    switch (intent) {
      case RequestUserPermission():
        _requestUserPermissionForLocation(markerWidth: intent.markerWidth);
        break;
      case GetRoute():
        _getRoute(
          destination: intent.destination,
          markerWidth: intent.markerWidth,
          markerText: intent.markerText,
          iconPath: intent.iconPath,
        );
    }
  }

  void _requestUserPermissionForLocation({double? markerWidth}) async {
    emit(state.copyWith(requestLocationPermissionStatus: Status.loading));
    try {
      bool serviceEnabled;
      serviceEnabled = await _location.serviceEnabled();

      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        emit(state.copyWith(requestLocationPermissionStatus: Status.success));
        if (!serviceEnabled) {
          emit(
            state.copyWith(
              requestLocationPermissionStatus: Status.error,
              error: LocationPermissionDenied(),
            ),
          );
          return;
        }
      }
      if (serviceEnabled) {
        emit(state.copyWith(requestLocationPermissionStatus: Status.success));
        _getCurrentLocation(markerWidth: markerWidth);
      }
    } catch (e) {
      emit(
        state.copyWith(requestLocationPermissionStatus: Status.error, error: e),
      );
    }
  }

  void _getCurrentLocation({double? markerWidth}) async {
    try {
      emit(state.copyWith(getCurrentUserLocationStatus: Status.loading));
      var userLocation = await _location.getLocation();
      currentLocation = userLocation;
      newLocationNotifier = ValueNotifier(userLocation);
      markers.add(
        Marker(
          point: LatLng(userLocation.latitude!, userLocation.longitude!),
          width: 150,
          height: 90,
          child: const MarkerChildWidget(
            iconPath: AssetsPaths.locationPinIcon,
            text: "Your Location",
          ),
        ),
      );
      emit(state.copyWith(getCurrentUserLocationStatus: Status.success));
    } catch (e) {
      currentLocation = null;
      emit(
        state.copyWith(getCurrentUserLocationStatus: Status.error, error: e),
      );
    }
  }

  void whenUserLocationChanges() {
    _location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;
      newLocationNotifier.value = newLocation;
    });
  }

  void _getRoute({
    required LatLng destination,
    double? markerWidth,
    required String markerText,
    required String iconPath,
  }) async {
    if (currentLocation == null) return;
    final start = LatLng(
      currentLocation!.latitude!,
      currentLocation!.longitude!,
    );
    emit(state.copyWith(getDirectionBetweenPointsStatus: Status.loading));
    var useCaseResult = await _getDirectionsUseCase.call(
      directionRequestEntity: DirectionsRequestEntity(
        coordinates: [
          [start.longitude, start.latitude],
          [destination.longitude, destination.latitude],
        ],
      ),
    );
    switch (useCaseResult) {
      case Success<DirectionsResponseEntity>():
        var coordinates =
            useCaseResult.data.features?.first.geometry?.coordinates;
        if (coordinates != null || coordinates!.isNotEmpty) {
          routePoints =
              coordinates
                  .map((e) => LatLng(e[1].toDouble(), e[0].toDouble()))
                  .toList();
          markers.add(
            Marker(
              point: LatLng(destination.latitude, destination.longitude),
              width: markerWidth ?? 30,
              height: 90,
              child: MarkerChildWidget(iconPath: iconPath, text: markerText),
            ),
          );
        }
        emit(state.copyWith(getDirectionBetweenPointsStatus: Status.success));
        break;
      case Error<DirectionsResponseEntity>():
        emit(
          state.copyWith(
            getDirectionBetweenPointsStatus: Status.error,
            error: useCaseResult.error,
          ),
        );
    }
  }
}

sealed class LocationMapIntent {}

class RequestUserPermission extends LocationMapIntent {
  double? markerWidth;

  RequestUserPermission({this.markerWidth});
}

class GetRoute extends LocationMapIntent {
  LatLng destination;
  double? markerWidth;
  String markerText;
  String iconPath;

  GetRoute({
    required this.destination,
    this.markerWidth,
    required this.markerText,
    required this.iconPath,
  });
}
