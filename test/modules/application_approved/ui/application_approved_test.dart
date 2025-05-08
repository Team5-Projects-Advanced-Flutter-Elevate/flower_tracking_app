import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/validation/validation_functions.dart';
import 'package:flower_tracking_app/modules/application_approved/ui/application_approved.dart';
import 'package:flower_tracking_app/shared_layers/localization/enums/languages_enum.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flower_tracking_app/shared_layers/localization/l10n_manager/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'application_approved_test.mocks.dart';

@GenerateMocks([LocalizationManager])
@GenerateNiceMocks([MockSpec<NavigatorObserver>()])
void main() {
  group("Application Approved Screen Tests", () {
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
        home: const ApplicationApproved(),
        navigatorObservers: [navigatorObserver],
      );
    }

    testWidgets("Should display check icon and messages", (tester) async {
      // Arrange
      await tester.pumpWidget(buildWidget());

      // Act
      final checkIcon = find.byType(Image);
      final titleText = find.text(appLocalizations.applicationSubmitted);
      final descriptionText = find.text(
        appLocalizations.thanksForProvidingApplication,
      );
      final loginButton = find.text(appLocalizations.login);

      // Assert
      expect(
        checkIcon,
        findsWidgets,
      ); // Image used for both background and icon
      final descriptionText =
          find.text(appLocalizations.thanksForProvidingApplication);
      final loginButton = find.text(appLocalizations.login);

      // Assert
      expect(checkIcon, findsWidgets); // Image used for both background and icon
      expect(titleText, findsOneWidget);
      expect(descriptionText, findsOneWidget);
      expect(loginButton, findsOneWidget);
    });
  });
}
