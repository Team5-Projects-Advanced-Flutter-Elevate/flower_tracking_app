import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flower_tracking_app/core/apis/api_error/api_error_handler.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/home/ui/widget/custom_pending_orders.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/pending_orders/pending_orders_cubit.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/pending_orders/pending_orders_state.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
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
                  style: theme.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.mainColor,
                    fontFamily: GoogleFonts.imFellEnglish().fontFamily,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      appLocalizations.readyForDelivery,
                      style: theme.textTheme.labelMedium,
                    ),
                    SizedBox(width: screenWidth * 0.008),
                    Switch(
                      overlayColor: theme.switchTheme.overlayColor,
                      trackColor: theme.switchTheme.trackColor,
                      thumbColor: theme.switchTheme.thumbColor,
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
                value: cubit,
                child: CustomMaterialIndicator(
                  backgroundColor: AppColors.white,
                  indicatorBuilder: (context, controller) {
                    return Transform.scale(
                      scale: 1.2,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
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
                  onRefresh: () {
                    return cubit.doIntent(RefreshOrdersIntent());
                  },
                  child: BlocConsumer<OrdersCubit, OrdersState>(
                    listener: (context, state) {
                      if (state.status == LoadOrdersStatus.error) {
                        displaySnackBar(
                          contentType: ContentType.failure,
                          title: AppLocalizations.of(context)!.error,
                          message: getIt<ApiErrorHandler>().handle(
                            state.error!,
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
                        return Center(
                          child: Text(appLocalizations.noOrdersFound),
                        );
                      }
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.builder(
                          controller: _scrollController,
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
                                  appLocalizations.unKnownProduct,
                              price: order.totalPrice.toInt().toString(),
                              pickUpAddress:
                                  order.store.address ??
                                  appLocalizations.unKnownAddress,
                              pickUpImage:
                                  order.store.image,
                              pickUpName:
                                  order.store.name ??
                                  appLocalizations.unKnownStore,
                              userAddress:
                                  order.shippingAddress?.street ??
                                  order.store.address ??
                                  appLocalizations.unKnownAddress,
                              userFirstName:
                                  order.user.firstName ??
                                  appLocalizations.unKnown,
                              userLastName: order.user.lastName ?? '',
                              userImage:
                                  order.user.photo ,
                              onAccept: () {},
                              onReject: () {
                                context.read<OrdersCubit>().removeOrder(order.id);
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
