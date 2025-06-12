import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/validation/validation_functions.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/widgets/language_row.dart';
import 'package:flower_tracking_app/shared_layers/localization/enums/languages_enum.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flower_tracking_app/shared_layers/localization/l10n_manager/localization_manager.dart';

import '../../../../../onboarding/ui/onboarding_screen_test.mocks.dart';

@GenerateMocks([LocalizationManager])
void main() {
  late AppLocalizations appLocalizations;
  late MockLocalizationManager mockLocalizationManager;
  late ValidateFunctions validateFunctions;

  setUpAll(() async {
    final languageCode = LanguagesEnum.en.getLanguageCode();

    // Load localization
    appLocalizations = await AppLocalizations.delegate.load(
      Locale(languageCode),
    );

    // Create mock localization manager
    mockLocalizationManager = MockLocalizationManager();
    when(mockLocalizationManager.currentLocale).thenReturn(languageCode);

    // Register dependencies
    validateFunctions = ValidateFunctions(appLocalizations);
    getIt.registerSingleton<AppLocalizations>(appLocalizations);
    getIt.registerSingleton<LocalizationManager>(mockLocalizationManager);
    getIt.registerSingleton<ValidateFunctions>(validateFunctions);
  });

  testWidgets('LanguageRow renders correctly and triggers locale change', (
    WidgetTester tester,
  ) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BaseInheritedWidget(
          theme: ThemeData.light(),
          screenWidth: 375,
          screenHeight: 812,
          appLocalizations: appLocalizations,
          localizationManager: mockLocalizationManager,
          validateFunctions: validateFunctions,
          child: const Scaffold(body: LanguageRow()),
        ),
      ),
    );

    // Assert visuals
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.text(appLocalizations.language), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.text(appLocalizations.english), findsOneWidget);

    // Act - tap the language switch button
    await tester.tap(find.byType(TextButton));
    await tester.pump();

    // Assert callback
    verify(
      mockLocalizationManager.changeLocal(LanguagesEnum.ar.getLanguageCode()),
    ).called(1);
  });
}
