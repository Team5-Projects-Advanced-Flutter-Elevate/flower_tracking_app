import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/core/apis/api_error/api_error_handler.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/routing/defined_routes.dart';
import 'package:flower_tracking_app/core/widgets/loading_state_widget.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/login/request/login_request_entity.dart';
import 'package:flower_tracking_app/modules/authentication/ui/login/view_model/login_state.dart';
import 'package:flower_tracking_app/modules/authentication/ui/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injectable_initializer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseStatefulWidgetState<LoginScreen> {
  bool isRememberMe = false, isPasswordObscure = true;
  LoginViewModel loginViewModel = getIt.get<LoginViewModel>();
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginViewModel,
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            appLocalizations.login,
            style: theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.03,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: loginViewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      validator: (value) {
                        return validateFunctions.validationOfEmail(value);
                      },
                      onFieldSubmitted: (value) {
                        passwordFocusNode.requestFocus();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        label: Text(appLocalizations.email),
                        hintText: appLocalizations.enterEmail,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: passwordController,
                      obscuringCharacter: "*",
                      obscureText: isPasswordObscure,
                      focusNode: passwordFocusNode,
                      validator: (value) {
                        return validateFunctions.validationOfPassword(value);
                      },
                      onFieldSubmitted: (value) {
                        passwordFocusNode.unfocus();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        label: Text(appLocalizations.password),
                        hintText: appLocalizations.enterPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordObscure = !isPasswordObscure;
                            });
                          },
                          icon: Icon(
                            isPasswordObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isRememberMe,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) {
                            setState(() {
                              isRememberMe = value ?? false;
                            });
                          },
                        ),
                        Text(
                          appLocalizations.rememberMe,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              DefinedRoutes.forgetPasswordScreenRoute,
                            );
                          },
                          child: Text(
                            appLocalizations.forgetPassword,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.25),
                    BlocConsumer<LoginViewModel, LoginState>(
                      listener: (context, state) {
                        switch (state.loginStatus) {
                          case Status.idle:
                          case Status.loading:
                            break;
                          case Status.success:
                            displaySnackBar(
                              contentType: ContentType.success,
                              title: appLocalizations.loggedSuccessfully,
                            );
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              DefinedRoutes.homeScreenRoute,
                              (route) => false,
                            );
                          case Status.error:
                            displaySnackBar(
                              contentType: ContentType.failure,
                              title: getIt.get<ApiErrorHandler>().handle(
                                state.error!,
                              ),
                            );
                        }
                      },
                      builder: (context, state) {
                        return FilledButton(
                          onPressed: () {
                            loginViewModel.doIntent(
                              Login(
                                loginRequest: LoginRequestEntity(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                                rememberMe: isRememberMe,
                              ),
                            );
                          },
                          child:
                              state.loginStatus == Status.loading
                                  ? LoadingStateWidget(
                                    progressIndicatorColor: AppColors.white,
                                  )
                                  : Text(appLocalizations.continueWord),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
