import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/modules/edit_profile/ui/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/bases/base_inherited_widget.dart';
import '../../../../../../core/bases/base_statless_widget.dart';
import '../../../../../../core/colors/app_colors.dart';
import '../../../../../../core/constants/assets_paths/assets_paths.dart';

class UserCard extends BaseStatelessWidget {
  const UserCard(this.loggedDriverDataResponseEntity, {super.key});

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
          CircleAvatar(
            radius: 27,
            backgroundImage:
                loggedDriverDataResponseEntity.driver?.photo!.isNotEmpty == true
                    ? NetworkImage(
                      loggedDriverDataResponseEntity.driver!.photo!,
                    )
                    : const AssetImage(AssetsPaths.flowerLogo),
          ),
          SizedBox(width: inherit.screenWidth * .04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loggedDriverDataResponseEntity.driver!.firstName ?? '',
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontSize: 16 * (inherit.screenWidth / 375),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: inherit.screenHeight * .01),
              Text(
                loggedDriverDataResponseEntity.driver!.email ?? '',
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 10 * (inherit.screenWidth / 375),
                ),
              ),
              Text(
                loggedDriverDataResponseEntity.driver!.phone ?? '',
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 10 * (inherit.screenWidth / 375),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
            child: Icon(Icons.arrow_forward_ios, color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
