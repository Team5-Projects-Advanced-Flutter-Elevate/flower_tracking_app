import 'package:auto_size_text/auto_size_text.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flower_tracking_app/core/routing/defined_routes.dart';
import 'package:flower_tracking_app/modules/onboarding/ui/constants/onboarding_keys_value.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends BaseStatefulWidgetState<OnboardingScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.1),
                    child: Transform.scale(
                      scale: 2.1,
                      alignment: Alignment.center,
                      child: Lottie.asset(AssetsPaths.onboardingAnimation),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AutoSizeText(
                        appLocalizations.onboardingWelcomeMessage,
                        maxLines: 2,
                        minFontSize: 14,
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      FilledButton(
                        key: const Key(OnboardingKeysValues.loginButton),
                        onPressed: () async {
                          Navigator.pushNamed(
                            context,
                            DefinedRoutes.loginScreenRoute,
                          );
                        },
                        child: Text(appLocalizations.login),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      OutlinedButton(
                        key: const Key(OnboardingKeysValues.applyButton),
                        onPressed: () {
                          // Todo: Navigate To Apply Screen
                        },
                        child: Text(appLocalizations.applyNow),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
