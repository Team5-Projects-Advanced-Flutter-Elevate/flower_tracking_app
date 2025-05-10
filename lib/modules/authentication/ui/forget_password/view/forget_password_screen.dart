import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/modules/authentication/ui/forget_password/view/reset_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../core/validation/validation_functions.dart';
import '../../../../../core/widgets/loading_state_widget.dart';
import '../view_model/forget_password_screen_view_model.dart';
import '../view_model/forget_password_state.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

late TextEditingController emailController;

class _ForgetPasswordScreenState
    extends BaseStatefulWidgetState<ForgetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ForgetPasswordViewModel forgetPasswordViewModel =
      getIt.get<ForgetPasswordViewModel>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => forgetPasswordViewModel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, size: screenWidth * 0.06),
            ),
            title: Text(
              appLocalizations.password,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    appLocalizations.forgetPassword,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    appLocalizations.forgetPasswordDescription,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  TextFormField(
                    validator:
                        (value) =>
                            getIt<ValidateFunctions>().validationOfEmail(value),

                    controller: emailController,
                    decoration: InputDecoration(
                      enabled: true,
                      hintText: appLocalizations.enterEmail,
                      labelText: appLocalizations.email,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  BlocConsumer<ForgetPasswordViewModel, PasswordState>(
                    builder: (context, state) {
                      if (state is PasswordLoadingState) {
                        return const LoadingStateWidget();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            forgetPasswordViewModel.onIntent(
                              ForgotPasswordIntent(emailController.text.trim()),
                            );
                          }
                        },
                        child: Text(appLocalizations.confirm),
                      );
                    },
                    listener: (context, state) {
                      if (state is EmailSuccessState) {
                        displaySnackBar(
                          contentType: ContentType.success,
                          title: appLocalizations.success,
                          message: appLocalizations.codeSendTitle,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ResetCodeScreen(
                                  email: emailController.text.trim(),
                                ),
                          ),
                        );
                      } else if (state is EmailErrorState) {
                        displaySnackBar(
                          contentType: ContentType.failure,
                          title: appLocalizations.error,
                          message: '${state.error}',
                        );
                      } else if (state is EmailLoadingState) {
                        LoadingStateWidget(
                          progressIndicatorColor: AppColors.mainColor,
                        );
                      }
                    },
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
