// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
// import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
// import 'package:flower_tracking_app/core/validation/validation_functions.dart';
// import 'package:flower_tracking_app/modules/home/ui/profile/ui/widgets/logout_row.dart';
// import 'package:flower_tracking_app/shared_layers/localization/enums/languages_enum.dart';
// import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
// import 'package:flower_tracking_app/shared_layers/localization/l10n_manager/localization_manager.dart';
//
// import '../../../../../onboarding/ui/onboarding_screen_test.mocks.dart';
// @GenerateMocks([LocalizationManager])
// void main() {
//   late AppLocalizations appLocalizations;
//   late LocalizationManager mockLocalizationManager;
//   late ValidateFunctions validateFunctions;
//
//   setUpAll(() async {
//     final languageCode = LanguagesEnum.en.getLanguageCode();
//
//     // Load localization
//     appLocalizations = await AppLocalizations.delegate.load(Locale(languageCode));
//
//     // Mock localization manager
//     mockLocalizationManager = MockLocalizationManager();
//     when(mockLocalizationManager.currentLocale).thenReturn(languageCode);
//
//     // Register singletons
//     validateFunctions = ValidateFunctions(appLocalizations);
//     getIt.registerSingleton<AppLocalizations>(appLocalizations);
//     getIt.registerSingleton<LocalizationManager>(mockLocalizationManager);
//     getIt.registerSingleton<ValidateFunctions>(validateFunctions);
//   });
//
//   testWidgets('LogoutRow renders correctly with icons and text', (WidgetTester tester) async {
//     // Act
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BaseInheritedWidget(
//           theme: ThemeData.light(),
//           screenWidth: 375,
//           screenHeight: 812,
//           appLocalizations: appLocalizations,
//           localizationManager: mockLocalizationManager,
//           validateFunctions: validateFunctions,
//           child: const Scaffold(body: LogoutRow()),
//         ),
//       ),
//     );
//
//     // Assert
//     expect(find.text(appLocalizations.logout), findsOneWidget);
//     expect(find.byIcon(Icons.logout), findsNWidgets(2));
//     expect(find.byType(IconButton), findsOneWidget);
//
//     // Verify icon button is tappable
//     await tester.tap(find.byType(IconButton));
//     await tester.pump(); // no error should occur
//   });
// }
