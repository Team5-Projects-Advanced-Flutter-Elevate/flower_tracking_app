import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/validation/validation_functions.dart';
import 'package:flower_tracking_app/modules/onboarding/ui/constants/onboarding_keys_value.dart';
import 'package:flower_tracking_app/modules/onboarding/ui/onboarding_screen.dart';
import 'package:flower_tracking_app/shared_layers/localization/enums/languages_enum.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flower_tracking_app/shared_layers/localization/l10n_manager/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_screen_test.mocks.dart';

@GenerateMocks([LocalizationManager])
@GenerateNiceMocks([MockSpec<NavigatorObserver>()])
void main() {
  group("Onboarding Screen Testing Items", () {
    late AppLocalizations appLocalizations;
    late String languageCode;
    late NavigatorObserver navigatorObserver;
    setUp(() {
      navigatorObserver = MockNavigatorObserver();
    });
    setUpAll(() async {
      languageCode = LanguagesEnum.ar.getLanguageCode();
      appLocalizations = await AppLocalizations.delegate.load(
        Locale(languageCode),
      );
      LocalizationManager localizationManager = MockLocalizationManager();
      when(localizationManager.currentLocale).thenReturn(languageCode);
      ValidateFunctions validateFunctions = ValidateFunctions(appLocalizations);
      getIt.registerSingleton<AppLocalizations>(appLocalizations);
      getIt.registerSingleton<LocalizationManager>(localizationManager);
      getIt.registerSingleton<ValidateFunctions>(validateFunctions);
    });
    Widget buildWidget() {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(languageCode),
        home: const OnboardingScreen(),
        navigatorObservers: [navigatorObserver],
      );
    }

    testWidgets(
      "When the onboarding screen is opened, onboarding animation should be rendered",
      (widgetTester) async {
        // arrange
        await widgetTester.pumpWidget(buildWidget());
        // action
        Finder animation = find.byType(Lottie);
        await widgetTester.ensureVisible(animation);

        // assert
        expect(animation, findsOneWidget);
      },
    );

    testWidgets(
      "When the onboarding screen is opened, the welcome massage should be rendered",
      (widgetTester) async {
        // arrange
        await widgetTester.pumpWidget(buildWidget());

        // act
        Finder welcomeMessage = find.text(
          appLocalizations.onboardingWelcomeMessage,
        );

        // assert
        expect(welcomeMessage, findsOneWidget);
      },
    );
    testWidgets(
      "When the onboarding screen is opened, the login button should be rendered",
      (widgetTester) async {
        // arrange
        await widgetTester.pumpWidget(buildWidget());

        // act
        Finder loginButton = find.byKey(
          const Key(OnboardingKeysValues.loginButton),
        );

        // assert
        expect(loginButton, findsOneWidget);
      },
    );
    testWidgets(
      "When the onboarding screen is opened, the apply now button should be rendered",
      (widgetTester) async {
        // arrange
        await widgetTester.pumpWidget(buildWidget());

        // act
        Finder applyButton = find.byKey(
          const Key(OnboardingKeysValues.applyButton),
        );

        // assert
        expect(applyButton, findsOneWidget);
      },
    );
  });
}
