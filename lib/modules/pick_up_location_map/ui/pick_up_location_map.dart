import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/core/apis/api_error/api_error_handler.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/widgets/error_state_widget.dart';
import 'package:flower_tracking_app/core/widgets/loading_state_widget.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/ui/constants/location_map_constants.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/ui/view_model/location_map_view_model.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/ui/view_model/location_states.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/order/order_entity_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/constants/assets_paths/assets_paths.dart';
import '../../../core/di/injectable_initializer.dart';
import '../../order_details/widgets/address_item.dart';

/*
  Big Note:
    The Open Street Service with its APIs it takes the longitude before the latitude same as the coordinates response coming from the APIs.
    But with Flutter Map Widget, it takes the latitude first and then the longitude.

*/

class PickUpLocationMap extends StatefulWidget {
  const PickUpLocationMap({super.key});

  @override
  State<PickUpLocationMap> createState() => _PickUpLocationMapState();
}

class _PickUpLocationMapState
    extends BaseStatefulWidgetState<PickUpLocationMap> {
  LocationMapViewModel locationMapViewModel = getIt.get<LocationMapViewModel>();
  bool errorLoadingMap = false;
  bool getRouteCalledOnce = false;
  ApiErrorHandler apiErrorHandler = getIt.get<ApiErrorHandler>();
  late OrderEntityFirestore firstOrderEntity, secondOrderEntity;

  @override
  void initState() {
    super.initState();
  }

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
                  : Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocConsumer<LocationMapViewModel, LocationStates>(
                            listenWhen: (previous, current) {
                              if (previous.getDirectionBetweenPointsStatus !=
                                  current.getDirectionBetweenPointsStatus) {
                                return true;
                              }
                              return false;
                            },
                            listener: (context, state) {
                              switch (state.getDirectionBetweenPointsStatus) {
                                case Status.error:
                                  displaySnackBar(
                                    contentType: ContentType.failure,
                                    title: "Error!",
                                    message: apiErrorHandler.handle(
                                      state.error!,
                                    ),
                                    durationInSeconds: 4,
                                  );
                                default:
                                  break;
                              }
                            },
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
                                      if (!getRouteCalledOnce) {
                                        locationMapViewModel.doIntent(
                                          GetRoute(
                                            destination: const LatLng(
                                              30.7823150,
                                              30.9981280,
                                            ),
                                            // const LatLng(
                                            //   30.0561110,
                                            //   31.3563610,
                                            // ),
                                            markerWidth: screenWidth * 0.37,
                                            markerText: "User",
                                            iconPath: AssetsPaths.userHomeIcon,
                                          ),
                                        );
                                        getRouteCalledOnce = true;
                                      }
                                      switch (state
                                          .getDirectionBetweenPointsStatus) {
                                        case Status.idle:
                                        case Status.loading:
                                          return const LoadingStateWidget();
                                        default:
                                          return Expanded(
                                            child: FlutterMap(
                                              mapController:
                                                  locationMapViewModel
                                                      .mapController,
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
                                                  // print(point.latitude);
                                                  // print(point.longitude);
                                                  // setState(() {
                                                  //   locationMapViewModel.markers.add(
                                                  //     Marker(
                                                  //       point: point,
                                                  //       width: screenWidth * 0.37,
                                                  //       height: 35,
                                                  //       child: const MarkerChildWidget(
                                                  //         iconPath:
                                                  //             AssetsPaths
                                                  //                 .locationPinIcon,
                                                  //         text: "New Location",
                                                  //       ),
                                                  //     ),
                                                  //   );
                                                  // });
                                                },
                                              ),
                                              children: [
                                                TileLayer(
                                                  urlTemplate:
                                                      LocationMapConstants
                                                          .tileUrl,
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
                                                      color:
                                                          AppColors.mainColor,
                                                      strokeWidth: 5,
                                                      points:
                                                          locationMapViewModel
                                                              .routePoints,
                                                    ),
                                                  ],
                                                ),

                                                MarkerLayer(
                                                  markers:
                                                      locationMapViewModel
                                                          .markers,
                                                ),
                                              ],
                                            ),
                                          );
                                      }
                                    case Status.error:
                                      return ErrorStateWidget(
                                        error: state.error!,
                                      );
                                  }
                                case Status.error:
                                  return Column(
                                    children: [
                                      Icon(
                                        Icons.error,
                                        size: 34,
                                        color: AppColors.red,
                                      ),
                                      SizedBox(height: screenHeight * 0.02),
                                      ErrorStateWidget(error: state.error!),
                                    ],
                                  );
                              }
                            },
                          ),
                        ],
                      ),
                      DraggableScrollableSheet(
                        maxChildSize: 0.38,
                        minChildSize: 0.04,
                        initialChildSize: 0.38,
                        builder: (context, scrollController) {
                          return Container(
                            color: AppColors.white,
                            child: ListView(
                              controller: scrollController,
                              children: [
                                Center(
                                  child: Container(
                                    width: 70,
                                    height: 4,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                            left: Radius.circular(10),
                                            right: Radius.circular(10),
                                          ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Text("Pickup Address"),
                                ),
                                const AddressItem(
                                  title: "unknown",
                                  address: "address",
                                  phoneNumber: "01010518801",
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Text("User Address"),
                                ),
                                const AddressItem(
                                  title: "unknown",
                                  address: "address",
                                  phoneNumber: "01010518801",
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 7),
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
