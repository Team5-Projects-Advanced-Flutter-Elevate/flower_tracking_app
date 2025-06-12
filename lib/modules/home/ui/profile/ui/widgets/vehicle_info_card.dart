import 'package:flutter/material.dart';
import '../../../../../../core/bases/base_inherited_widget.dart';
import '../../../../../../core/bases/base_statless_widget.dart';
import '../../../../../../core/colors/app_colors.dart';
import '../../../../../authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';

class VehicleInfoCard extends BaseStatelessWidget {
  const VehicleInfoCard(this.loggedDriverDataResponseEntity, {super.key});

  final LoggedDriverDataResponseEntity loggedDriverDataResponseEntity;

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          const BoxShadow(
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 0),
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inherit.appLocalizations.vehicleInfo,
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontSize: 16 * (inherit.screenWidth / 375),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: inherit.screenHeight * .01),
              Text(
                loggedDriverDataResponseEntity.driver!.vehicleType ?? '',
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12 * (inherit.screenWidth / 375),
                ),
              ),
              SizedBox(height: inherit.screenHeight * .01),

              Text(
                loggedDriverDataResponseEntity.driver!.vehicleNumber ?? '',
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12 * (inherit.screenWidth / 375),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              // Navigate to edit vehicle info screen
            },
            child: Icon(Icons.arrow_forward_ios, color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
