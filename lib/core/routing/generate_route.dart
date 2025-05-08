import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/routing/defined_routes.dart';
import 'package:flower_tracking_app/modules/apply/ui/apply_view.dart';
import 'package:flower_tracking_app/modules/apply/ui/view_model/apply_cubit.dart';
import 'package:flower_tracking_app/modules/onboarding/ui/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    // var args = routeSettings.arguments;
    var name = routeSettings.name;

    switch (name) {
      case DefinedRoutes.onboardingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );

      case DefinedRoutes.apply:
        ApplyCubit cubit = getIt<ApplyCubit>()..doIntent(LoadApplyDataIntent());
        return MaterialPageRoute(
          builder:
              (context) =>
                  BlocProvider.value(value: cubit, child: const ApplyView()),
        );
      default:
        return _errorRoute();
    }
  }

  static List<Route<dynamic>> onGenerateInitialRoutes({
    String? initialRoute,
    dynamic loginInfo,
    bool rememberMe = false,
  }) {
    return [
      if (loginInfo != null)
        MaterialPageRoute(
          builder: (context) => const SizedBox(), //HomeScreen(),
        )
      else
        MaterialPageRoute(
          builder: (context) => const SizedBox(), //const LoginScreen(),
        ),
    ];
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Center(
          child: Container(
            color: Colors.red,
            child: const Text(
              "Error! You Have Navigated To A Wrong Route. Or Navigated With Wrong Arguments",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
