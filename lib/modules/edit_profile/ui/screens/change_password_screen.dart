import 'package:flower_tracking_app/core/widgets/error_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../core/di/injectable_initializer.dart';
import '../../../../core/validation/validation_functions.dart';
import '../../../../core/widgets/loading_state_widget.dart';
import '../cubit/states.dart';
import '../cubit/view_model.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends BaseStatefulWidgetState<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  EditProfileViewModel editProfileViewModel = getIt.get<EditProfileViewModel>();
  bool isEnabled = false;

  bool isCurrentPasswordObscure = true,
      isNewPasswordObscure = true,
      isConfirmPasswordObscure = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocProvider(
        create: (context) => editProfileViewModel,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Reset Password",
              style: GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocListener<EditProfileViewModel, ProfileState>(
              listener: (context, state) {
                switch (state.changePasswordStatus) {
                  case EditProfileStatus.initial:
                    break;
                  case EditProfileStatus.loading:
                    const LoadingStateWidget();

                  case EditProfileStatus.success:
                    displaySnackBar(
                      contentType: ContentType.success,
                      title: 'Success',
                      message: 'Updated Successfully',
                    );
                  case EditProfileStatus.error:
                    ErrorStateWidget(error: state.error.toString());
                }
              },
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Current Password Field
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _currentPasswordController,
                        obscureText: isCurrentPasswordObscure,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          labelText: 'Current password',
                          hintText: 'Current password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isCurrentPasswordObscure =
                                    !isCurrentPasswordObscure;
                              });
                            },
                            icon: Icon(
                              isCurrentPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator:
                            (value) => getIt<ValidateFunctions>()
                                .validationOfPassword(value),
                      ),
                      const SizedBox(height: 20),

                      // New Password Field
                      TextFormField(
                        controller: _newPasswordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: isNewPasswordObscure,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          labelText: 'New password',
                          hintText: 'Confirm password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isNewPasswordObscure = !isNewPasswordObscure;
                              });
                            },
                            icon: Icon(
                              isNewPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator:
                            (value) => getIt<ValidateFunctions>()
                                .validationOfPassword(value),
                      ),
                      const SizedBox(height: 20),

                      // Confirm Password Field
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _confirmPasswordController,
                        obscureText: isConfirmPasswordObscure,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          labelText: 'Confirm password',
                          hintText: 'Confirm password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordObscure =
                                    !isConfirmPasswordObscure;
                              });
                            },
                            icon: Icon(
                              isConfirmPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator:
                            (value) => getIt<ValidateFunctions>()
                                .validationOfConfirmPassword(
                                  value,
                                  _newPasswordController.text,
                                ),
                      ),
                      const SizedBox(height: 40),

                      // Update Button
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_formKey.currentState!.validate()) {
                              editProfileViewModel.onIntent(
                                ChangePassword(
                                  _currentPasswordController.text,

                                  _newPasswordController.text,
                                ),
                              );
                            }
                          },
                          child: const Text('update'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
