import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flower_tracking_app/core/bases/base_statless_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors/app_colors.dart';

class TotalMoneySection extends BaseStatelessWidget {
  const TotalMoneySection({super.key});

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
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            inherit.appLocalizations.total,
            style: inherit.theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${inherit.appLocalizations.egp} 600 ',
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
