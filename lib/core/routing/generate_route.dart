import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/routing/defined_routes.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/ui/apply_view.dart';
import 'package:flower_tracking_app/modules/apply/ui/view_model/apply_cubit.dart';
import 'package:flower_tracking_app/modules/application_approved/ui/application_approved.dart';
import 'package:flower_tracking_app/modules/onboarding/ui/onboarding_screen.dart';
import 'package:flutter/material.dart';
import '../../modules/authentication/ui/login/login_screen.dart';
import '../../modules/home/ui/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    // var args = routeSettings.arguments;
    var name = routeSettings.name;

    try {
      switch (name) {
        case DefinedRoutes.onboardingScreenRoute:
          return MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          );
        case DefinedRoutes.loginScreenRoute:
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        case DefinedRoutes.homeScreenRoute:
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        case DefinedRoutes.apply:
          ApplyCubit cubit =
              getIt<ApplyCubit>()..doIntent(LoadApplyDataIntent());
          return MaterialPageRoute(
            builder:
                (context) =>
                    BlocProvider.value(value: cubit, child: const ApplyView()),
          );
        default:
          return _errorRoute();
      }
    } catch (e) {
      return _errorRoute();
    
    switch (name) {
      case DefinedRoutes.onboardingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case DefinedRoutes.applicationApproved:
        return MaterialPageRoute(
          builder: (context) => const ApplicationApproved(),
        );
      default:
        return _errorRoute();
    }
  }
  }

  static List<Route<dynamic>> onGenerateInitialRoutes({
    String? initialRoute,
    LoggedDriverDataResponseEntity? loginInfo,
  }) {
    return [
      if (loginInfo != null)
        MaterialPageRoute(builder: (context) => const HomeScreen())
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
