import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/core/utilities/extensions/int_extension/int_extension.dart';
import 'package:flower_tracking_app/core/widgets/loading_state_widget.dart';
import 'package:flower_tracking_app/modules/order_details/view_model/order_details_state.dart';
import 'package:flower_tracking_app/modules/order_details/view_model/order_details_view_model.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/address_item.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/order_details_item.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/order_details_static_data.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/order_status_section.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/payment_method_section.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/section_title_text_item.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/status_container.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/total_money_section.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/ui/pick_up_location_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/apis/api_error/api_error_handler.dart';
import '../../core/bases/base_stateful_widget_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/di/injectable_initializer.dart';
import '../../core/routing/defined_routes.dart';
import '../../core/widgets/error_state_widget.dart';
import '../../shared_layers/database/firestore/constants/firestore_constants.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState
    extends BaseStatefulWidgetState<OrderDetailsScreen> {
  final dataList = OrderDetailsStaticData.getDataList();
  final OrderDetailsViewModel orderDetailsViewModel =
      getIt.get<OrderDetailsViewModel>();
  late String driverId;
  bool isAnimating = true;
  @override
  void initState() {
    super.initState();
    driverId = getIt.get(instanceName: FirestoreConstants.driverId);
    orderDetailsViewModel.doIntent(
      ReadOrderInfo(driverId: driverId, orderId: widget.orderId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => orderDetailsViewModel,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 16,
          title: Text(
            appLocalizations.orderDetails,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 20 * (screenWidth / 375),
            ),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<OrderDetailsViewModel, OrderDetailsState>(
            listener: (context, state) {
              switch (state.updateOrderStateStatus) {
                case Status.idle:
                case Status.loading:
                  break;
                case Status.success:
                  if (orderDetailsViewModel.selectedIndex == 4) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      Future.delayed(const Duration(seconds: 2), () async {
                        if (!context.mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          DefinedRoutes.thanksPageScreenRoute,
                          (route) => false,
                        );
                        displaySnackBar(
                          contentType: ContentType.success,
                          title: appLocalizations.orderFinishedSuccessfully,
                        );
                      });
                    });
                  }
                case Status.error:
                  displaySnackBar(
                    contentType: ContentType.failure,
                    title: getIt<ApiErrorHandler>().handle(state.error!),
                  );
              }
            },
            builder: (context, state) {
              switch (state.orderStatus) {
                case Status.idle:
                  return const SizedBox();
                case Status.loading:
                  return const LoadingStateWidget();
                case Status.success:
                  final orderEntity = state.orderEntityFirestore;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: screenHeight * .008),
                        height: screenHeight * .0044,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * .02,
                                    ),
                                    child: SizedBox(
                                      width: screenWidth * .16,
                                      child: LinearProgressIndicator(
                                        color:
                                            orderDetailsViewModel
                                                        .selectedIndex >=
                                                    index
                                                ? AppColors.green
                                                : AppColors.white[70],
                                        value: 1,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * .008),
                      Expanded(
                        child: ListView(
                          children: [
                            OrderStatusSection(
                              dataList: dataList,
                              selectedIndex:
                                  orderDetailsViewModel.selectedIndex,
                              orderId: orderEntity?.orderNumber ?? '',
                              estimatedTime:
                                  orderEntity?.receivedUserOrderAt
                                      ?.getDataFormatAfterAdding(
                                        const Duration(hours: 2),
                                      ) ??
                                  orderDetailsViewModel.receivedUserOrderAt
                                      ?.getDataFormatAfterAdding(
                                        const Duration(hours: 2),
                                      ),
                            ),
                            SectionTitleTextItem(
                              title: appLocalizations.pickupAddress,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              overlayColor: WidgetStateColor.transparent,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DefinedRoutes.pickUpLocationMap,
                                  arguments: PickUpLocationMapWidgetParams(
                                    storeEntity: orderEntity?.store,
                                    userEntity: orderEntity?.user,
                                  ),
                                );
                              },
                              child: AddressItem(
                                title: orderEntity?.store?.name,
                                address: orderEntity?.store?.address,
                                phoneNumber: orderEntity?.store?.phoneNumber,
                              ),
                            ),
                            SectionTitleTextItem(
                              title: appLocalizations.userAddress,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              overlayColor: WidgetStateColor.transparent,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DefinedRoutes.pickUpLocationMap,
                                  arguments: PickUpLocationMapWidgetParams(
                                    showStoreFirst: false,
                                    storeEntity: orderEntity?.store,
                                    userEntity: orderEntity?.user,
                                  ),
                                );
                              },
                              child: AddressItem(
                                title:
                                    orderEntity?.user?.firstName == null &&
                                            orderEntity?.user?.lastName == null
                                        ? null
                                        : "${orderEntity?.user?.firstName ?? ''} ${orderEntity?.user?.lastName ?? ''}",
                                address: orderEntity?.store?.address,
                                phoneNumber: orderEntity?.user?.phone,
                              ),
                            ),
                            SectionTitleTextItem(
                              title: appLocalizations.orderDetails,
                            ),
                            Column(
                              children: List.generate(
                                orderEntity?.orderItems?.length ?? 0,
                                (index) {
                                  return OrderDetailsItem(
                                    orderItem: orderEntity?.orderItems?[index],
                                  );
                                },
                              ),
                            ),
                            TotalMoneySection(
                              totalPrice: orderEntity?.totalPrice,
                            ),
                            PaymentMethodSection(
                              paymentType: orderEntity?.paymentType,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.white[70]!,
                              blurRadius: 1.5,
                              spreadRadius: 1.5,
                              offset: const Offset(1, 1),
                              blurStyle: BlurStyle.outer,
                            ),
                          ],
                          //border: Border.all(color: AppColors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        //height: screenHeight * .11,
                        width: screenWidth,
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.024,

                          horizontal: screenWidth * .04,
                        ),
                        child: StatusButton(
                          containerStatus: state.updateOrderStateStatus,
                          onPress:
                              orderDetailsViewModel.selectedIndex ==
                                      dataList.length - 1
                                  ? null
                                  : () {
                                    //orderDetailsViewModel.selectedIndex++;
                                    orderDetailsViewModel.doIntent(
                                      OnOrderStatusButtonClick(
                                        driverId: driverId,
                                        orderId: widget.orderId,
                                        buttonIndex:
                                            orderDetailsViewModel.selectedIndex,
                                      ),
                                    );
                                  },
                          buttonTitle: dataList[orderDetailsViewModel
                                  .selectedIndex]
                              .getButtonTitle(context),
                        ),
                      ),
                    ],
                  );
                case Status.error:
                  return ErrorStateWidget(error: state.error!);
              }
            },
          ),
        ),
      ),
    );
  }
}
