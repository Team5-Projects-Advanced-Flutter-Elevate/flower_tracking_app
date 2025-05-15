import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flower_tracking_app/core/bases/base_statless_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import 'order_details_static_data.dart';

class OrderStatusSection extends BaseStatelessWidget {
  const OrderStatusSection({
    super.key,

    required this.dataList,
    required this.selectedIndex,
  });

  final List<OrderDetailsStaticData> dataList;
  final int selectedIndex;

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(8),
      ),
      width: inherit.screenWidth,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),

      child: Column(
        spacing: inherit.screenHeight * .01,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${inherit.appLocalizations.status}: ${dataList[selectedIndex].getStatus(context)}',
            style: inherit.theme.textTheme.titleMedium!.copyWith(
              color: AppColors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${inherit.appLocalizations.orderId}: #123656',
            style: inherit.theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Wed, 03 Sep 2024, 11:00 AM ',
            style: inherit.theme.textTheme.labelLarge!.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
