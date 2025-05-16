import 'package:flower_tracking_app/core/bases/base_statless_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors/app_colors.dart';

class PaymentMethodSection extends BaseStatelessWidget {
  final String? paymentType;
  const PaymentMethodSection({super.key, required this.paymentType});

  @override
  Widget customBuild(BuildContext context, inherit) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            inherit.appLocalizations.paymentMethod,
            style: inherit.theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            paymentType?.replaceFirst(
                  paymentType![0],
                  paymentType![0].toUpperCase(),
                ) ??
                inherit.appLocalizations.unKnown,
            style: GoogleFonts.roboto(
              textStyle: inherit.theme.textTheme.labelLarge!.copyWith(
                color: AppColors.gray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
