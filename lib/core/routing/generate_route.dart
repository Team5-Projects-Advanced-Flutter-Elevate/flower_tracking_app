import 'package:flower_tracking_app/core/routing/defined_routes.dart';
import 'package:flower_tracking_app/modules/application_approved/ui/application_approved.dart';
import 'package:flower_tracking_app/modules/apply/ui/apply_view.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/modules/authentication/ui/forget_password/view/forget_password_screen.dart';
import 'package:flower_tracking_app/modules/home/layout_screen.dart';
import 'package:flower_tracking_app/modules/authentication/ui/forget_password/view/reset_password_screen.dart';
import 'package:flower_tracking_app/modules/onboarding/ui/onboarding_screen.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/ui/pick_up_location_map.dart';
import 'package:flutter/material.dart';
import '../../modules/authentication/ui/login/login_screen.dart';
import '../../modules/home/ui/profile/ui/profile_screen.dart';
import '../../modules/order_details/order_details_screen.dart';
import '../../modules/thanks_page/ui/thanks_page_screen.dart';

abstract class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    var args = routeSettings.arguments;
    var name = routeSettings.name;
    try {
      switch (name) {
        case DefinedRoutes.onboardingScreenRoute:
          return MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          );
        case DefinedRoutes.loginScreenRoute:
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        case DefinedRoutes.forgetPasswordScreenRoute:
          return MaterialPageRoute(
            builder: (context) => const ForgetPasswordScreen(),
          );
        case DefinedRoutes.applicationApproved:
          return MaterialPageRoute(
            builder: (context) => const ApplicationApproved(),
          );
        case DefinedRoutes.layoutScreen:
          return MaterialPageRoute(builder: (context) => const LayoutScreen());
        case DefinedRoutes.profileScreen:
          return MaterialPageRoute(builder: (context) => const ProfileScreen());
        case DefinedRoutes.apply:
          return MaterialPageRoute(builder: (context) => const ApplyView());
        case DefinedRoutes.orderDetailsRoute:
          return MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(orderId: args as String),
          );
        case DefinedRoutes.pickUpLocationMap:
          return MaterialPageRoute(
            builder:
                (context) => PickUpLocationMap(
                  params: args as PickUpLocationMapWidgetParams,
                ),
          );
        case DefinedRoutes.thanksPageScreenRoute:
          return MaterialPageRoute(
            builder: (context) => const ThanksPageScreen(),
          );

        case DefinedRoutes.resetPasswordRoute:
          return MaterialPageRoute(
            builder: (context) => const ResetPasswordScreen(),
          );

        default:
          return _errorRoute();
      }
    } catch (e) {
      return _errorRoute();
    }
  }

  static List<Route<dynamic>> onGenerateInitialRoutes({
    String? initialRoute,
    String? currentAcceptedOrderId,
    LoggedDriverDataResponseEntity? loginInfo,
  }) {
    return [
      if (loginInfo != null)
        if (currentAcceptedOrderId != null)
          MaterialPageRoute(
            builder:
                (context) =>
                    OrderDetailsScreen(orderId: currentAcceptedOrderId),
          )
        else
          MaterialPageRoute(builder: (context) => const LayoutScreen())
      else
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    ];
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Material(
          child: Container(
            color: Colors.red,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Error! You Have Navigated To A Wrong Route. Or Navigated With Wrong Arguments",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
