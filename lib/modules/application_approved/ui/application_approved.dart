import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/themes/app_themes.dart';
import 'package:flutter/material.dart';

class ApplicationApproved extends StatefulWidget {
  const ApplicationApproved({super.key});

  @override
  State<ApplicationApproved> createState() => _ApplicationApprovedState();
}

class _ApplicationApprovedState
    extends BaseStatefulWidgetState<ApplicationApproved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/icons/bg.png",
              fit: BoxFit.fitWidth,
              width: screenWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 281,
              top: 149,
              left: 30,
              right: 30,
            ),
            child: Column(
              children: [
                Image.asset('assets/icons/check-circle.png'),
                SizedBox(height: screenHeight * 0.024),
                Text(
                  appLocalizations.applicationSubmitted,
                  textAlign: TextAlign.center,
                  style: AppThemes.lightTheme.textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.024),
                Text(
                  appLocalizations.thanksForProvidingApplication,
                  textAlign: TextAlign.center,
                  style: AppThemes.lightTheme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: screenHeight * 0.022),
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.047,
                  child: FilledButton(
                    onPressed: () {},
                    child: Text(appLocalizations.login,style: AppThemes.lightTheme.textTheme.titleMedium!.copyWith(color: AppColors.white,fontSize: 13,),),
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
