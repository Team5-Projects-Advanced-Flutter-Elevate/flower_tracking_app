import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/routing/defined_routes.dart';
import 'package:flower_tracking_app/core/themes/app_themes.dart';
import 'package:flower_tracking_app/core/validation/validation_functions.dart';
import 'package:flower_tracking_app/modules/home/layout_screen.dart';
import 'package:flower_tracking_app/modules/home/ui/constants/home_constants.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/pending_orders/pending_orders_cubit.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/pending_orders/pending_orders_state.dart';
import 'package:flower_tracking_app/modules/thanks_page/ui/constants/thanks_page_constants.dart';
import 'package:flower_tracking_app/modules/thanks_page/ui/thanks_page_screen.dart';
import 'package:flower_tracking_app/shared_layers/localization/enums/languages_enum.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flower_tracking_app/shared_layers/localization/l10n_manager/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'thanks_page_screen_test.mocks.dart';

@GenerateMocks([LocalizationManager, OrdersCubit])
void main() {
  group("Test Thanks Page widget appearance", () {
    late String languageCode;
    late AppLocalizations appLocalizations;
    late ValidateFunctions validateFunctions;
    late LocalizationManager localizationManager;
    setUpAll(() async {
      languageCode = LanguagesEnum.en.getLanguageCode();
      appLocalizations = await AppLocalizations.delegate.load(
        Locale(languageCode),
      );
      validateFunctions = ValidateFunctions(appLocalizations);
      localizationManager = MockLocalizationManager();
    });
    Widget buildWidget() {
      return Builder(
        builder: (context) {
          return BaseInheritedWidget(
            theme: AppThemes.lightTheme,
            screenWidth: MediaQuery.of(context).size.width,
            screenHeight: MediaQuery.of(context).size.height,
            appLocalizations: appLocalizations,
            localizationManager: localizationManager,
            validateFunctions: validateFunctions,
            child: MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(languageCode),
              home: const ThanksPageScreen(),
            ),
          );
        },
      );
    }

    testWidgets(
      "When the ThanksPageScreen is opened, the success icon with its background color should be rendered",
      (widgetTester) async {
        // arrange
        await widgetTester.pumpWidget(buildWidget());

        // act
        Finder successIconWithBackground = find.byKey(
          const Key(ThanksPageConstants.successIconKey),
        );

        // assert
        expect(successIconWithBackground, findsOneWidget);
      },
    );

    testWidgets(
      "When the ThanksPageScreen is opened, the Thank You message with order delivered successfully should be rendered",
      (widgetTester) async {
        // arrange
        await widgetTester.pumpWidget(buildWidget());

        // act
        Finder successMessage = find.byKey(
          const Key(ThanksPageConstants.successMessageKey),
        );

        // assert
        expect(successMessage, findsOneWidget);
      },
    );
    testWidgets(
      "When the ThanksPageScreen is opened, the Done Button should be rendered",
      (widgetTester) async {
        // arrange
        await widgetTester.pumpWidget(buildWidget());

        // act
        Finder doneButton = find.byKey(
          const Key(ThanksPageConstants.doneButtonKey),
        );

        // assert
        expect(doneButton, findsOneWidget);
      },
    );
  });

  group("Test Thanks page widgets actions", () {
    late String languageCode;
    late AppLocalizations appLocalizations;
    late ValidateFunctions validateFunctions;
    late LocalizationManager localizationManager;
    late OrdersCubit ordersCubit;
    setUpAll(() async {
      languageCode = LanguagesEnum.en.getLanguageCode();
      appLocalizations = await AppLocalizations.delegate.load(
        Locale(languageCode),
      );
      validateFunctions = ValidateFunctions(appLocalizations);
      localizationManager = MockLocalizationManager();
      ordersCubit = MockOrdersCubit();
      getIt.registerFactory<LocalizationManager>(() {
        return localizationManager;
      });
      getIt.registerFactory<ValidateFunctions>(() {
        return validateFunctions;
      });
      getIt.registerFactory<OrdersCubit>(() {
        return ordersCubit;
      });
      when(ordersCubit.state).thenReturn(const OrdersState());
      when(
        ordersCubit.stream,
      ).thenAnswer((_) => Stream.value(const OrdersState()));
    });
    Widget buildWidget() {
      return Builder(
        builder: (context) {
          return BaseInheritedWidget(
            theme: AppThemes.lightTheme,
            screenWidth: MediaQuery.of(context).size.width,
            screenHeight: MediaQuery.of(context).size.height,
            appLocalizations: appLocalizations,
            localizationManager: localizationManager,
            validateFunctions: validateFunctions,
            child: MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(languageCode),
              onGenerateRoute: (settings) {
                debugPrint("In on generate route====================>");
                var name = settings.name;
                try {
                  switch (name) {
                    case DefinedRoutes.layoutScreen:
                      return MaterialPageRoute(
                        builder: (context) => const LayoutScreen(),
                      );
                    case DefinedRoutes.thanksPageScreenRoute:
                      return MaterialPageRoute(
                        builder: (context) => const ThanksPageScreen(),
                      );
                    default:
                      return MaterialPageRoute(
                        builder: (context) => const SizedBox(),
                      );
                  }
                } catch (e) {
                  return MaterialPageRoute(
                    builder: (context) => const SizedBox(),
                  );
                }
              },
              home: const ThanksPageScreen(),
            ),
          );
        },
      );
    }

    testWidgets(
      "When clicking on the done button after the ThanksPage opens, it should navigate us to the home screen",
      (widgetTester) async {
        // arrange
        await widgetTester.pumpWidget(buildWidget());

        // act
        Finder doneButton = find.byKey(
          const Key(ThanksPageConstants.doneButtonKey),
        );

        await widgetTester.tap(doneButton);
        await widgetTester.pumpAndSettle();

        Finder layoutScreen = find.byKey(const Key(HomeConstants.layoutScreenKey));

        // assert
        expect(layoutScreen, findsOneWidget);
      },
    );
  });
}
