import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/core/utilities/bloc_observer/location_permission_denied.dart';
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
  LocationMapViewModel() : super(const LocationStates());
  final MapController mapController = MapController();
  LocationData? currentLocation;
  List<LatLng> routePoints = [];
  List<Marker> markers = [];
  final String orsApiKey =
      '5b3ce3597851110001cf6248c5d72244043d4ab1a710379a6bc133f4';

  final Location _location = Location();

  late ValueNotifier<LocationData> newLocationNotifier;

  void doIntent(LocationMapIntent intent) {
    switch (intent) {
      case RequestUserPermission():
        _requestUserPermissionForLocation(markerWidth: intent.markerWidth);
        break;
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
          width: markerWidth ?? 30,
          height: 35,
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

  void getRoute(LatLng destination) {
    if (currentLocation == null) return;
    final start = LatLng(
      currentLocation!.latitude!,
      currentLocation!.longitude!,
    );
  }
}

sealed class LocationMapIntent {}

class RequestUserPermission extends LocationMapIntent {
  double? markerWidth;

  RequestUserPermission({this.markerWidth});
}
