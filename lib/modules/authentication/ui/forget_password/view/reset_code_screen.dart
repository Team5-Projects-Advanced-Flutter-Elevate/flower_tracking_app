import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/modules/authentication/ui/forget_password/view/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../core/widgets/loading_state_widget.dart';
import '../view_model/forget_password_screen_view_model.dart';
import '../view_model/forget_password_state.dart';
import 'forget_password_screen.dart';
import 'package:flower_tracking_app/core/widgets/timer.dart';

class ResetCodeScreen extends StatefulWidget {
  const ResetCodeScreen({super.key});

  @override
  State<ResetCodeScreen> createState() => _ResetCodeScreenState();
}

class _ResetCodeScreenState extends BaseStatefulWidgetState<ResetCodeScreen> {
  bool sent = true;
  bool resend = false;
  bool _hasError = false;
  final ValueNotifier<bool> _isLessThan5Minutes = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();
  ForgetPasswordViewModel forgetPasswordViewModel =
      getIt.get<ForgetPasswordViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => forgetPasswordViewModel,
      child: BlocConsumer<ForgetPasswordViewModel, PasswordState>(
        builder:
            (context, state) => Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: screenWidth * 0.05,
                      ),
                    ),
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      Text(
                        'Email verification',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(fontSize: screenWidth * 0.045),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Please enter your code that send to your email address ',
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Center(
                        child: OTPTextField(
                          length: 6,
                          width: screenWidth * 0.75,
                          otpFieldStyle: OtpFieldStyle(
                            errorBorderColor: Colors.red,
                          ),
                          style: TextStyle(fontSize: screenWidth * 0.0425),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.box,
                          hasError: _hasError,
                          onChanged: (value) {
                            if (_hasError) {
                              setState(() {
                                _hasError =
                                    false; // Reset error once user starts editing
                              });
                            }
                          },
                          onCompleted: (code) {
                            forgetPasswordViewModel.onIntent(
                              ResetCodeIntent(code),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Did not receive code?',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          resend == false
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Timer(
                                    isLessThan5Minutes: _isLessThan5Minutes,
                                    examDuration: 30,
                                    onTimeEnd: () {
                                      setState(() {
                                        resend = true;
                                      });
                                    },
                                  ),
                                ],
                              )
                              : InkWell(
                                onTap: () {
                                  forgetPasswordViewModel.onIntent(
                                    ForgotPasswordIntent(emailController.text),
                                  );
                                },
                                child: Text(
                                  'Resend',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.mainColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.mainColor,
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        listener: (context, state) {
          if (state is PasswordSuccessState) {
            displaySnackBar(
              contentType: ContentType.success,
              title: 'Success',
              message: 'Code is valid',
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(),));


          } else if (state is PasswordErrorState) {
            setState(() {
              _hasError = true;
            });
            displaySnackBar(
              contentType: ContentType.failure,
              title: 'fail',
              message: 'Code not valid',
            );
          } else if (state is PasswordLoadingState) {
            const LoadingStateWidget();
          }
        },
      ),
    );
  }
}
