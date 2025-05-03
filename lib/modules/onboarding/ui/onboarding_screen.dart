import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flower_tracking_app/shared_layers/localization/enums/languages_enum.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/widgets/loading_state_widget.dart';

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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text("Hello"),
        ),
        bottomNavigationBar: NavigationBar(
          destinations: [
            const NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            const NavigationDestination(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10,
                children: [
                  Transform.scale(
                    scale: 1.7,
                    child: Lottie.asset(
                      AssetsPaths.onboardingAnimation,
                      fit: BoxFit.fitWidth,
                      width: screenWidth,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03,),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: textEditingController,
                      validator: (value) {
                        return validateFunctions.validationOfEmail(value);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: "Label",
                        hintText: "Enter Something",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                  Text(
                    validateFunctions.validationOfEmail("ljklsdkfjldskfj")!,
                    style: theme.textTheme.bodyLarge,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      localizationManager.isEnglish
                          ? await localizationManager.changeLocal(
                            LanguagesEnum.ar.getLanguageCode(),
                          )
                          : await localizationManager.changeLocal(
                            LanguagesEnum.en.getLanguageCode(),
                          );
                      formKey.currentState!.validate();
                    },
                    child: Text(appLocalizations.login),
                  ),
                  FilledButton(onPressed: () {}, child: const Text("Test")),
                  OutlinedButton(
                    onPressed: () {
                      displaySnackBar(
                        contentType: ContentType.success,
                        title: "Displayed Successfully",
                        message: "SnackBar Displayed Successfully",
                      );
                    },
                    child: const Text("Display Snack Bar"),
                  ),
                  const LoadingStateWidget(),
                  Radio<String>(
                    value: "value1",
                    groupValue: "value1",

                    onChanged: (value) {},
                  ),
                  Radio<String>(
                    value: "value1",
                    groupValue: "value2",
                    onChanged: (value) {},
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
