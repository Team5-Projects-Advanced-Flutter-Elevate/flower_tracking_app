import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/bases/base_statless_widget.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_paths/assets_paths.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseStatefulWidgetState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Text('Profile'),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: SvgPicture.asset(AssetsPaths.notificationIcon),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            const UserCard(),
            SizedBox(height: screenHeight * 0.03),
            const VehicleInfoCard(),
            SizedBox(height: screenHeight * 0.03),
            const LanguageRow(),
            SizedBox(height: screenHeight * 0.01),
            const LogoutRow(),
          ],
        ),
      ),
    );
  }
}

class LanguageRow extends BaseStatelessWidget {
  const LanguageRow({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Row(
      children: [
        SvgPicture.asset(AssetsPaths.languageIcon),
        SizedBox(width: inherit.screenWidth * 0.01),
        Text('Language', style: inherit.theme.textTheme.bodyMedium),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            'English',
            style: inherit.theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.mainColor,
            ),
          ),
        ),
      ],
    );
  }
}

class LogoutRow extends BaseStatelessWidget {
  const LogoutRow({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Row(
      children: [
        const Icon(Icons.logout, size: 20),
        SizedBox(width: inherit.screenWidth * 0.01),
        Text('Logout', style: inherit.theme.textTheme.bodyMedium),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.logout, size: 30, color: AppColors.gray),
        ),
      ],
    );
  }
}

class UserCard extends BaseStatelessWidget {
  const UserCard({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 0),
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 27,
            backgroundImage: AssetImage(AssetsPaths.flowerLogo),
          ),
          SizedBox(width: inherit.screenWidth * .04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontSize: 16 * (inherit.screenWidth / 375),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: inherit.screenHeight * .01),
              Text(
                'John Doe@gmail.com',
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12 * (inherit.screenWidth / 375),
                ),
              ),
              Text(
                '01094465408',
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12 * (inherit.screenWidth / 375),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.arrow_forward_ios, color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}

class VehicleInfoCard extends BaseStatelessWidget {
  const VehicleInfoCard({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 0),
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
                'Vehicle info',
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontSize: 16 * (inherit.screenWidth / 375),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Bike',
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12 * (inherit.screenWidth / 375),
                ),
              ),
              Text(
                'UPC 123456789',
                style: inherit.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12 * (inherit.screenWidth / 375),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.arrow_forward_ios, color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
