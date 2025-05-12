import 'package:flower_tracking_app/modules/order_details/widgets/address_item.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/order_details_item.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/order_details_static_data.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/payment_method_section.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/section_title_text_item.dart';
import 'package:flower_tracking_app/modules/order_details/widgets/total_money_section.dart';
import 'package:flutter/material.dart';

import '../../core/bases/base_stateful_widget_state.dart';
import '../../core/colors/app_colors.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState
    extends BaseStatefulWidgetState<OrderDetailsScreen> {
  final dataList = OrderDetailsStaticData.getDataList();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text(
          appLocalizations.orderDetails,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 20 * (screenWidth / 375),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: screenHeight * .008),
          SizedBox(
            height: screenHeight * .0044,

            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: screenWidth * 0.16,
                          child: LinearProgressIndicator(
                            color:
                                selectedIndex >= index
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightPink,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: screenWidth,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),

                    child: Column(
                      spacing: screenHeight * .01,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${appLocalizations.status}: ${dataList[selectedIndex].getStatus(context)}',
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${appLocalizations.orderId}: #123656',
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Wed, 03 Sep 2024, 11:00 AM ',
                          style: theme.textTheme.labelLarge!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SectionTitleTextItem(title: appLocalizations.pickupAddress),
                  const AddressItem(),
                  SectionTitleTextItem(title: appLocalizations.userAddress),
                  const AddressItem(),
                  SectionTitleTextItem(title: appLocalizations.orderDetails),
                  const OrderDetailsItem(),
                  const TotalMoneySection(),
                  const paymentMethodSection(),
                ],
              ),
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
            height: screenHeight * .11,
            width: screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * .027,
                horizontal: 16,
              ),
              child: FilledButton(
                style: FilledButton.styleFrom(),
                onPressed:
                    selectedIndex == dataList.length - 1
                        ? null
                        : () {
                          selectedIndex++;
                          setState(() {});
                        },
                child: Text(dataList[selectedIndex].getButtonTitle(context)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
