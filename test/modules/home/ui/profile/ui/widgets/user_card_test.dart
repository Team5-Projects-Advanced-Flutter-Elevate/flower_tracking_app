import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/validation/validation_functions.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/widgets/user_card.dart';
import 'package:flower_tracking_app/shared_layers/localization/enums/languages_enum.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flower_tracking_app/shared_layers/localization/l10n_manager/localization_manager.dart';

import 'user_card_test.mocks.dart';

@GenerateMocks([LocalizationManager])
void main() {
  late AppLocalizations appLocalizations;
  late LocalizationManager mockLocalizationManager;
  late ValidateFunctions validateFunctions;

  setUpAll(() async {
    final languageCode = LanguagesEnum.ar.getLanguageCode();

    // Load localization
    appLocalizations = await AppLocalizations.delegate.load(
      Locale(languageCode),
    );

    // Create mock localization manager
    mockLocalizationManager = MockLocalizationManager();
    when(mockLocalizationManager.currentLocale).thenReturn(languageCode);

    // Register singletons
    validateFunctions = ValidateFunctions(appLocalizations);
    getIt.registerSingleton<AppLocalizations>(appLocalizations);
    getIt.registerSingleton<LocalizationManager>(mockLocalizationManager);
    getIt.registerSingleton<ValidateFunctions>(validateFunctions);
  });

  testWidgets('UserCard displays driver info correctly', (
    WidgetTester tester,
  ) async {
    // Arrange
    final testDriver = LoggedDriverDataResponseEntity(
      driver: DriverEntity(
        firstName: 'John',
        email: 'john.doe@example.com',
        phone: '+1234567890',
        photo: '',
      ),
    );

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
          child: UserCard(testDriver),
        ),
      ),
    );

    // Assert
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text('John'), findsOneWidget);
    expect(find.text('john.doe@example.com'), findsOneWidget);
    expect(find.text('+1234567890'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
  });
}
