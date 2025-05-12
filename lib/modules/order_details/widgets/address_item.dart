import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flower_tracking_app/core/bases/base_statless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_paths/assets_paths.dart';

class AddressItem extends BaseStatelessWidget {
  const AddressItem({super.key});

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
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.only(end: 8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(AssetsPaths.flowerLogo),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inherit.appLocalizations.floweryStore,
                style: inherit.theme.textTheme.bodySmall!.copyWith(
                  fontSize: 13,
                  color: AppColors.gray,
                ),
              ),
              Row(
                children: [
                  const ImageIcon(AssetImage(AssetsPaths.locationIcon)),
                  Text(
                    '20th st, Sheikh Zayed, Giza ',
                    style: GoogleFonts.roboto(
                      textStyle: inherit.theme.textTheme.bodySmall!.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: inherit.screenWidth * 0.15),
          ImageIcon(
            const AssetImage(AssetsPaths.callIcon),
            color: AppColors.mainColor,
          ),

          SvgPicture.asset(AssetsPaths.whatsappIcon),
        ],
      ),
    );
  }
}
