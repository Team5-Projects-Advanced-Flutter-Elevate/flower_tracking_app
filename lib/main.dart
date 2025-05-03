import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/routing/defined_routes.dart';
import 'package:flower_tracking_app/core/routing/generate_route.dart';
import 'package:flower_tracking_app/core/themes/app_themes.dart';
import 'package:flower_tracking_app/core/validation/validation_functions.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flower_tracking_app/shared_layers/localization/l10n_manager/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt.get<LocalizationManager>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationManager>(
      builder: (context, localizationManager, child) {
        return BaseInheritedWidget(
          theme: AppThemes.lightTheme,
          screenWidth: MediaQuery.of(context).size.width,
          screenHeight: MediaQuery.of(context).size.height,
          appLocalizations: getIt.get<AppLocalizations>(),
          localizationManager: getIt.get<LocalizationManager>(),
          validateFunctions: getIt.get<ValidateFunctions>(),
          child: MaterialApp(
            title: 'Flower Driver App',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            themeMode: ThemeMode.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(localizationManager.currentLocale),
            navigatorKey: globalNavigatorKey,
            onGenerateRoute: GenerateRoute.onGenerateRoute,
            initialRoute: DefinedRoutes.onboardingScreenRoute,
            // onGenerateInitialRoutes: (initialRoute) {
            //   return GenerateRoute.onGenerateInitialRoutes(
            //     initialRoute: initialRoute,
            //     loginInfo: null,
            //     rememberMe: false
            //   );
            // },
          ),
        );
      },
    );
  }
}
