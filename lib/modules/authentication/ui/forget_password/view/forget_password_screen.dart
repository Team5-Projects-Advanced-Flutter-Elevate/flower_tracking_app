import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/modules/authentication/ui/forget_password/view/reset_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../core/validation/validation_functions.dart';
import '../../../../../core/widgets/error_state_widget.dart';
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
              'Password',
              style: Theme.of(context).textTheme.labelMedium,
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
                    'Forget Password',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: screenWidth *
                              0.045, // roughly equivalent to 18.sp
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                   'Please enter your email associated to your account',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  TextFormField(
                    validator: (value) => getIt<ValidateFunctions>().validationOfEmail(value),

                    controller: emailController,
                    decoration: const InputDecoration(
                      enabled: true,
                      hintText: 'Enter Your Email',
                      labelText: 'Email',
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
                        child: const Text('Confirm'),
                      );
                    },
                    listener: (context, state) {
                      if (state is PasswordSuccessState) {


                        displaySnackBar(
                          contentType:ContentType.success ,
                          title: 'Success',
                        message: 'Code Send to Email',
                        );

                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetCodeScreen(),));

                      } else if (state is PasswordErrorState) {
                        ErrorStateWidget(error: state.error);
                      } else if (state is PasswordLoadingState) {
                        const LoadingStateWidget();
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
