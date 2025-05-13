import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flower_tracking_app/modules/home/ui/widget/custom_pending_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/themes/app_themes.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/pending_orders/pending_orders_cubit.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/pending_orders/pending_orders_state.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulWidgetState<HomeScreen> {
  bool light = true;
  final OrdersCubit cubit = GetIt.I<OrdersCubit>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit.doIntent(LoadOrdersIntent());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          cubit.state.status != LoadOrdersStatus.loadingMore) {
        cubit.doIntent(LoadMoreOrdersIntent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Building HomeScreen');
    const WidgetStateProperty<Color?> trackColor =
        WidgetStateProperty<Color?>.fromMap(<WidgetStatesConstraint, Color>{
          WidgetState.selected: Colors.green,
        });
    const WidgetStateProperty<Color?> overlayColor =
        WidgetStateProperty<Color?>.fromMap(<WidgetState, Color>{
          WidgetState.selected: Colors.green,
        });

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.060,
              left: screenWidth * 0.02,
              right: screenWidth * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.floweryRider,
                  style: AppThemes.lightTheme.textTheme.headlineMedium!
                      .copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.mainColor,
                        fontFamily: GoogleFonts.imFellEnglish().fontFamily,
                      ),
                ),
                Row(
                  children: [
                    Text(
                      appLocalizations.readyForDelivery,
                      style: AppThemes.lightTheme.textTheme.labelMedium,
                    ),
                    SizedBox(width: screenWidth * 0.008),
                    Switch(
                      overlayColor: overlayColor,
                      trackColor: trackColor,
                      thumbColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.black;
                        } else if (states.contains(WidgetState.selected)) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }),
                      value: light,
                      activeColor: AppColors.green,
                      onChanged: (bool value) {
                        setState(() {
                          light = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: BlocProvider.value(
                key: const Key('orders_cubit_provider'),
                value: cubit,
                child: CustomMaterialIndicator(
                  backgroundColor: AppColors.white,
            indicatorBuilder: (context, controller) {
              return Transform.scale(
                scale: 1.2,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  padding: const EdgeInsets.only(top: 6),
                  child: Center(
                    child: Transform.scale(
                      scale: 1.5,
                      child: Lottie.asset(
                        AssetsPaths.flowerLoadingAnimation,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              );
            },
                  onRefresh: ()  {
                        return cubit.doIntent(
                          RefreshOrdersIntent(),
                        );
                      },
                  child: BlocConsumer<OrdersCubit, OrdersState>(
                    listener: (context, state) {
                      if (state.status == LoadOrdersStatus.error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${state.error.toString()}'),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state.status == LoadOrdersStatus.loading &&
                          state.orders?.orders.isEmpty == true) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.status == LoadOrdersStatus.success &&
                          (state.orders?.orders.isEmpty ?? true)) {
                        return const Center(child: Text('No orders found'));
                      }
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.builder(
                          controller: _scrollController,
                          key: const Key('orders_list'),
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount:
                              (state.orders?.orders.length ?? 0) +
                              (state.status == LoadOrdersStatus.loadingMore
                                  ? 1
                                  : 0),
                          itemBuilder: (context, index) {
                            if (index == state.orders?.orders.length &&
                                state.status == LoadOrdersStatus.loadingMore) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            final order = state.orders!.orders[index];
                            final orderItem =
                                order.orderItems.isNotEmpty
                                    ? order.orderItems[0]
                                    : null;
                            return CustomPendingOrders(
                              title:
                                  orderItem?.product?.title ??
                                  'Unknown Product',
                              price:
                                  order.totalPrice?.toInt().toString() ?? '0',
                              pickUpAddress:
                                  order.store.address ?? 'Unknown Address',
                              pickUpImage:
                                  order.store.image ??
                                  'https://via.placeholder.com/150',
                              pickUpName: order.store.name ?? 'Unknown Store',
                              userAddress:
                                  order.shippingAddress?.street ??
                                  order.store.address ??
                                  'Unknown Address',
                              userFirstName: order.user.firstName ?? 'Unknown',
                              userLastName: order.user.lastName ?? '',
                              userImage:
                                  order.user.photo ??
                                  'https://via.placeholder.com/150',
                              onAccept: () {
                                // Implement accept logic
                              },
                              onReject: () {
                                // Implement reject logic
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
