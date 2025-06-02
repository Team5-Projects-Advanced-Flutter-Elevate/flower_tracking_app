import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/widgets/error_state_widget.dart';
import 'package:flower_tracking_app/core/widgets/loading_state_widget.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/ui/constants/location_map_constants.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/ui/view_model/location_map_view_model.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/ui/view_model/location_states.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/ui/widgets/marker_child_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/assets_paths/assets_paths.dart';
import '../../../core/di/injectable_initializer.dart';

class PickUpLocationMap extends StatefulWidget {
  const PickUpLocationMap({super.key});

  @override
  State<PickUpLocationMap> createState() => _PickUpLocationMapState();
}

class _PickUpLocationMapState
    extends BaseStatefulWidgetState<PickUpLocationMap> {
  LocationMapViewModel locationMapViewModel = getIt.get<LocationMapViewModel>();
  bool errorLoadingMap = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (locationMapViewModel.currentLocation == null) {
      locationMapViewModel.doIntent(
        RequestUserPermission(markerWidth: screenWidth * 0.37),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locationMapViewModel,
      child: Scaffold(
        body: SafeArea(
          child:
              errorLoadingMap
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: AppColors.red, size: 40),
                        SizedBox(height: screenHeight * 0.01),
                        const Text("Error Occurred While Loading The Map"),
                      ],
                    ),
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<LocationMapViewModel, LocationStates>(
                        builder: (context, state) {
                          switch (state.requestLocationPermissionStatus) {
                            case Status.idle:
                            case Status.loading:
                              return const LoadingStateWidget();
                            case Status.success:
                              switch (state.getCurrentUserLocationStatus) {
                                case Status.idle:
                                case Status.loading:
                                  return const LoadingStateWidget();
                                case Status.success:
                                  return Expanded(
                                    child: FlutterMap(
                                      mapController:
                                          locationMapViewModel.mapController,
                                      options: MapOptions(
                                        initialCenter: LatLng(
                                          locationMapViewModel
                                              .currentLocation!
                                              .latitude!,
                                          locationMapViewModel
                                              .currentLocation!
                                              .longitude!,
                                        ),
                                        initialZoom: 15.0,

                                        onTap: (tapPosition, point) {
                                          print(point.latitude);
                                          print(point.longitude);
                                          setState(() {
                                            locationMapViewModel.markers.add(
                                              Marker(
                                                point: point,
                                                width: screenWidth * 0.37,
                                                height: 35,
                                                child: const MarkerChildWidget(
                                                  iconPath:
                                                      AssetsPaths
                                                          .locationPinIcon,
                                                  text: "New Location",
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              LocationMapConstants.tileUrl,
                                          subdomains: ['a', 'b', 'c'],
                                          errorTileCallback: (
                                            tile,
                                            error,
                                            stackTrace,
                                          ) {
                                            setState(() {
                                              errorLoadingMap = true;
                                            });
                                          },
                                        ),
                                        PolylineLayer(
                                          polylines: [
                                            Polyline(
                                              color: AppColors.mainColor,
                                              strokeWidth: 5,

                                              points: [
                                                locationMapViewModel
                                                    .markers[0]
                                                    .point,
                                                if (locationMapViewModel
                                                        .markers
                                                        .length >
                                                    1)
                                                  locationMapViewModel
                                                      .markers[1]
                                                      .point,
                                              ],
                                            ),
                                          ],
                                        ),

                                        MarkerLayer(
                                          markers: locationMapViewModel.markers,
                                        ),
                                      ],
                                    ),
                                  );
                                case Status.error:
                                  return ErrorStateWidget(error: state.error!);
                              }
                            case Status.error:
                              return ErrorStateWidget(error: state.error!);
                          }
                        },
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
