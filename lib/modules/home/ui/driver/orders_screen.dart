import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/core/apis/api_error/api_error_handler.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/driver/pending_orders/pending_orders_state.dart';
import 'package:flower_tracking_app/modules/home/ui/widget/driver/custom_completed_or_not.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/driver/pending_orders/pending_orders_cubit.dart';
import 'package:flower_tracking_app/modules/home/ui/widget/driver/custom_pending_orders.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends BaseStatefulWidgetState<OrdersScreen> {
  bool light = true;
  final OrdersCubit cubit =
      getIt<OrdersCubit>(); // Use getIt instead of GetIt.I
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit.doIntent(LoadOrdersIntent());
    _controller.addListener(() {
      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 100 &&
          cubit.state.status != LoadOrdersStatus.loadingMore) {
        cubit.doIntent(LoadMoreOrdersIntent()); // Fixed method name
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.018),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios),
                ),
                SizedBox(width: screenWidth * 0.008),
                Text(
                  appLocalizations.myOrders,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaler.scale(20),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenHeight * 0.01,
            ),
            child: BlocBuilder<OrdersCubit, OrdersState>(
              bloc: cubit,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCompletedOrNot(
                      number: state.notCompletedOrdersCount,
                      icon: 'assets/icons/cancelled.png',
                      state: appLocalizations.cancelled,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.033),
                    CustomCompletedOrNot(
                      number: state.completedOrdersCount,
                      icon: 'assets/icons/completed.png',
                      state: appLocalizations.completed,
                    ),
                  ],
                );
              },
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
                  onRefresh: () => cubit.doIntent(RefreshOrdersIntent()),
                  child: BlocConsumer<OrdersCubit, OrdersState>(
                    listener: (context, state) {
                      if (state.status == LoadOrdersStatus.error) {
                        displaySnackBar(
                          contentType: ContentType.failure,
                          title: appLocalizations.error,
                          message: getIt<ApiErrorHandler>().handle(
                            state.error!,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state.status == LoadOrdersStatus.initial ||
                          (state.status == LoadOrdersStatus.loading &&
                              state.orders.orders.isEmpty)) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.status == LoadOrdersStatus.success &&
                          state.orders.orders.isEmpty) {
                        return Center(
                          child: Text(appLocalizations.noOrdersFound),
                        );
                      }
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.builder(
                          controller: _controller,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount:
                              state.orders.orders.length +
                              (state.status == LoadOrdersStatus.loadingMore
                                  ? 1
                                  : 0),
                          itemBuilder: (context, index) {
                            if (index == state.orders.orders.length &&
                                state.status == LoadOrdersStatus.loadingMore) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            final order = state.orders.orders[index];
                            final orderItem =
                                order.orderItems.isNotEmpty
                                    ? order.orderItems[0]
                                    : null;
                            return CustomPendingOrders(
                              icon:
                                  order.state != 'canceled'
                                      ? 'assets/icons/completed.png'
                                      : 'assets/icons/cancelled.png',
                              state: order.state,
                              title:
                                  orderItem?.product?.title ??
                                  appLocalizations.unKnownProduct,
                              pickUpAddress: order.store.address,
                              pickUpImage: order.store.image,
                              pickUpName: order.store.name,
                              userFirstName: order.user.firstName,
                              userLastName: order.user.lastName,
                              userImage: order.user.photo,
                              orderId: order.id,
                              onAccept: () {},
                              onReject: () {
                                context.read<OrdersCubit>().doIntent(
                                  RejectOrderIntent(order.id),
                                );
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
