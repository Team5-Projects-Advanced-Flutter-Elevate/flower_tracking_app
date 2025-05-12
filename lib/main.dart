import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/routing/generate_route.dart';
import 'package:flower_tracking_app/core/themes/app_themes.dart';
import 'package:flower_tracking_app/core/validation/validation_functions.dart';
import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/login/local/login_local_data_source.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flower_tracking_app/shared_layers/localization/l10n_manager/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'core/routing/defined_routes.dart';
import 'core/utilities/dio/dio_service/dio_service.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
LoggedDriverDataResponseEntity? loggedDriverData;

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await configureDependencies();

  final loginLocaleDataSource = getIt.get<LoginLocalDataSource>();
  final rememberValue = await loginLocaleDataSource.getRememberMeValue();
  if (!rememberValue) {
    await loginLocaleDataSource.deleteDriverData();
    await loginLocaleDataSource.deleteRememberMeValue();
  } else {
    loggedDriverData = await loginLocaleDataSource.getDriverData();
    DioServiceExtension.updateDioWithToken(loggedDriverData?.token ?? '');
  }
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

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
            locale: Locale('en'),
            navigatorKey: globalNavigatorKey,
            initialRoute: DefinedRoutes.orderDetailsRoute,

            onGenerateRoute: GenerateRoute.onGenerateRoute,
            /*  onGenerateInitialRoutes: (initialRoute) {
              return GenerateRoute.onGenerateInitialRoutes(
                initialRoute: initialRoute,
                loginInfo: loggedDriverData,
              );


            },*/
            //home: ForgetPasswordScreen(),
            // navigatorKey: globalNavigatorKey,
            // onGenerateRoute: GenerateRoute.onGenerateRoute,
            // initialRoute: DefinedRoutes.onboardingScreenRoute,
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
