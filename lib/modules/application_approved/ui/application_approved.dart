import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flower_tracking_app/core/routing/defined_routes.dart';
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
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.pushReplacementNamed(
      context,
      DefinedRoutes.onboardingScreenRoute,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetsPaths.applicationApprovedBackground,
              fit: BoxFit.fitWidth,
              width: screenWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.281,
              top: screenHeight * 0.149,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
            ),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      AssetsPaths.applicationApprovedCheckCircle,
                      width: screenWidth * 0.17,
                      height: screenHeight * 0.17,
                    ),
                    SizedBox(height: screenHeight * 0.020),
                    Text(
                      appLocalizations.applicationSubmitted,
                      textAlign: TextAlign.center,
                      style: AppThemes.lightTheme.textTheme.titleLarge!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: screenHeight * 0.020),
                    Text(
                      appLocalizations.thanksForProvidingApplication,
                      textAlign: TextAlign.center,
                      style: AppThemes.lightTheme.textTheme.titleMedium!
                          .copyWith(
                            color: AppColors.gray,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    SizedBox(height: screenHeight * 0.020),
                    SizedBox(
                      width: screenWidth,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            DefinedRoutes.loginScreenRoute,
                          );
                        },
                        child: Text(appLocalizations.login),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    BackButtonInterceptor.remove(myInterceptor);
  }
}
