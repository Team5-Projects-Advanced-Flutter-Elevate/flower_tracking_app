import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/driver/driver_entity_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/validation/validation_functions.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/widgets/vehicle_info_card.dart';
import 'package:flower_tracking_app/shared_layers/localization/enums/languages_enum.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flower_tracking_app/shared_layers/localization/l10n_manager/localization_manager.dart';
import '../../../../../onboarding/ui/onboarding_screen_test.mocks.dart';

@GenerateMocks([LocalizationManager])
void main() {
  late AppLocalizations appLocalizations;
  late LocalizationManager mockLocalizationManager;
  late ValidateFunctions validateFunctions;

  setUpAll(() async {
    final languageCode = LanguagesEnum.en.getLanguageCode(); // Use English or any supported locale

    // Load localization
    appLocalizations = await AppLocalizations.delegate.load(Locale(languageCode));

    // Create mock localization manager
    mockLocalizationManager = MockLocalizationManager();
    when(mockLocalizationManager.currentLocale).thenReturn(languageCode);

    // Register singletons
    validateFunctions = ValidateFunctions(appLocalizations);
    getIt.registerSingleton<AppLocalizations>(appLocalizations);
    getIt.registerSingleton<LocalizationManager>(mockLocalizationManager);
    getIt.registerSingleton<ValidateFunctions>(validateFunctions);
  });

  testWidgets('VehicleInfoCard displays vehicle data correctly', (WidgetTester tester) async {
    // Arrange
    final testDriver = LoggedDriverDataResponseEntity(
      driver: DriverEntityFirestore(
        vehicleType: 'Truck',
        vehicleNumber: 'ABC-1234',
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
          child: VehicleInfoCard(testDriver),
        ),
      ),
    );

    // Assert
    expect(find.text(appLocalizations.vehicleInfo), findsOneWidget);
    expect(find.text('Truck'), findsOneWidget);
    expect(find.text('ABC-1234'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
  });
}
