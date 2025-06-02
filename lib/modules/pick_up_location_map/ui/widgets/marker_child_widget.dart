import 'package:auto_size_text/auto_size_text.dart';
import 'package:flower_tracking_app/core/bases/base_statless_widget.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class MarkerChildWidget extends BaseStatelessWidget {
  final String iconPath;
  final String text;

  const MarkerChildWidget({
    super.key,
    required this.iconPath,
    required this.text,
  });

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: inherit.screenWidth * 0.02,vertical: 4),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(iconPath),
            ),
            SizedBox(width: inherit.screenWidth * 0.005,),
            Expanded(
              child: Center(
                child: AutoSizeText(
                  text,
                  maxFontSize: 18,
                  minFontSize: 8,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: inherit.theme.textTheme.labelMedium!.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
