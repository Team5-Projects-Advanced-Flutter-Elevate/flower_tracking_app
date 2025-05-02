import 'package:flower_tracking_app/main.dart';
import 'package:flutter/material.dart';
import '../validation/validation_functions.dart';

typedef VoidFunction = void Function()?;

abstract class BaseStatefulWidgetState<T extends StatefulWidget>
    extends State<T> {
  late ThemeData theme;
  late double screenWidth, screenHeight;
  late InheritedWidget easyLocalization;
  //late LocalizationManager localizationManager;
  late ValidateFunctions validateFunctions;

  // This will always point to the correct context
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    //localizationManager = getIt.get<LocalizationManager>();

    validateFunctions = ValidateFunctions.getInstance();
  }

  // Current fresh context with runtime check
  BuildContext get safeContext {
    try {
      // This will throw if context is inaccessible
      final ctx = context;
      // Verify we can use it
      if (ctx.mounted) {
        // Additional safety check
        return ctx;
      }
    } catch (_) {}

    // Fallback: Find the nearest context from the root
    return globalNavigatorKey
        .currentContext!; //getIt.get<GlobalKey<NavigatorState>>().currentContext!;
  }

  Future<void> displayAlertDialog() async {}

  void hideAlertDialog() {
    Navigator.of(context).pop();
  }
}
