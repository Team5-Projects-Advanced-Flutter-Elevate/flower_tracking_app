import 'package:flower_tracking_app/core/routing/defined_routes.dart';
import 'package:flower_tracking_app/core/routing/generate_route.dart';
import 'package:flower_tracking_app/core/themes/app_themes.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flower Driver App',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      themeMode: ThemeMode.light,
      navigatorKey: globalNavigatorKey,
      onGenerateRoute: GenerateRoute.onGenerateRoute,
      initialRoute: DefinedRoutes.apply,
      // onGenerateInitialRoutes: (initialRoute) {
      //   return GenerateRoute.onGenerateInitialRoutes(
      //     initialRoute: initialRoute,
      //     loginInfo: null,
      //     rememberMe: false
      //   );
      // },
    );
  }
}
