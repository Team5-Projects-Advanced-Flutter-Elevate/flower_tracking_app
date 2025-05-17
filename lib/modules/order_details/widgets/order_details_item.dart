import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flower_tracking_app/core/bases/base_statless_widget.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/order/order_entity_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_paths/assets_paths.dart';

class OrderDetailsItem extends BaseStatelessWidget {
  final OrderItemEntity? orderItem;
  const OrderDetailsItem({super.key, required this.orderItem});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Container(
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
      width: inherit.screenWidth,
      padding: EdgeInsets.all(inherit.screenWidth * .03),
      margin: EdgeInsets.all(inherit.screenWidth * .03),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: inherit.screenWidth * .02),
            child: const CircleAvatar(
              backgroundImage: AssetImage(AssetsPaths.flowerLogo),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        orderItem?.product?.title ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,

                        style: inherit.theme.textTheme.bodySmall!.copyWith(
                          fontSize: 13,
                          color: AppColors.gray,
                        ),
                      ),
                    ),
                    Text(
                      'X${orderItem?.quantity ?? 0}',
                      style: GoogleFonts.roboto(
                        textStyle: inherit.theme.textTheme.labelSmall!.copyWith(
                          fontSize: 13,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${inherit.appLocalizations.egp} ${orderItem?.product?.priceAfterDiscount ?? orderItem?.product?.price ?? 0} ',
                  style: GoogleFonts.roboto(
                    textStyle: inherit.theme.textTheme.labelSmall!.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
