import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../core/di/injectable_initializer.dart';
import '../../../../core/utilities/image_picker.dart';
import '../../../../core/validation/validation_functions.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_state_widget.dart';
import '../cubit/states.dart';
import '../cubit/view_model.dart';
import 'change_password_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState
    extends BaseStatefulWidgetState<EditProfileScreen> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  Gender? _selectedIndex;

  bool isDirty = false;

  late EditProfileViewModel editProfileViewModel;

  @override
  void initState() {
    super.initState();
    editProfileViewModel = getIt.get<EditProfileViewModel>();
    editProfileViewModel.onIntent(EditProfileIntent());
    // Attach listeners for dirty-check
    firstName.addListener(_checkDirty);
    lastName.addListener(_checkDirty);
    email.addListener(_checkDirty);
    phoneNumber.addListener(_checkDirty);
    password.addListener(_checkDirty);
  }

  void _checkDirty() {
    final state = editProfileViewModel.state;
    final changed =
        firstName.text != state.initialData?.firstName ||
        lastName.text != state.initialData?.lastName ||
        email.text != state.initialData?.email ||
        phoneNumber.text != state.initialData?.phoneNumber ||
        password.text != state.initialData?.password ||
        (_selectedIndex == Gender.male ? 'male' : 'female') !=
            state.initialData?.gender;

    if (changed != isDirty) {
      setState(() {
        isDirty = changed;
      });
    }
  }

  void _onGenderChanged(Gender? gender, ProfileState state) {
    setState(() {
      _selectedIndex = gender;
    });
    _checkDirty();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => editProfileViewModel,
      child: BlocConsumer<EditProfileViewModel, ProfileState>(
        listener: (context, state) {
          if (state.getProfileDataStatus == EditProfileStatus.success) {
            firstName.text = state.firstName;
            lastName.text = state.lastName;
            email.text = state.email;
            phoneNumber.text = state.phoneNumber;
            password.text = state.password;
            _selectedIndex =
                state.gender == 'male' ? Gender.male : Gender.female;
            _checkDirty(); // Refresh dirty check
          }

          if (state.updateProfileStatus == EditProfileStatus.success) {
            displaySnackBar(
              contentType: ContentType.success,
              title: 'Success',
              message: 'Updated Successfully',
            );
          } else if (state.updateProfileStatus == EditProfileStatus.error) {
            ErrorStateWidget(error: state.error.toString());
          } else if (state.getProfileDataStatus == EditProfileStatus.loading) {
            const LoadingStateWidget();
          } else if (state.uploadImageStatus == EditProfileStatus.success) {
            displaySnackBar(
              contentType: ContentType.success,
              title: 'Success',
              message: 'Updated Successfully',
            );
          } else if (state.uploadImageStatus == EditProfileStatus.error) {
            ErrorStateWidget(error: state.error.toString());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              automaticallyImplyLeading: false,
              titleSpacing: 0.0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios, size: screenWidth * 0.06),
              ),
              title: Text(
                'Edit profile',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  spacing: 25,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              child:
                                  state.profilePhotoLink == null
                                      ? const Icon(Icons.person)
                                      : CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                              "${state.profilePhotoLink}",
                                            ),
                                      ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.lightPink,
                              ),
                              child: GestureDetector(
                                onTap:
                                    () => ImagePickerService()
                                        .showImageSourceDialog(
                                          context,
                                          onImageSelected: (image) {
                                            editProfileViewModel.onIntent(
                                              LoadProfileImageIntent(image),
                                            );
                                          },
                                        ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.gray,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            validator:
                                (value) => getIt<ValidateFunctions>()
                                    .validationOfFullName(value),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: firstName,
                            decoration: const InputDecoration(
                              hintText: 'First Name',
                              labelText: 'First name',
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: TextFormField(
                            validator:
                                (value) => getIt<ValidateFunctions>()
                                    .validationOfFullName(value),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: lastName,
                            decoration: const InputDecoration(
                              hintText: 'Last Name',
                              labelText: 'Last name',
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      validator:
                          (value) => getIt<ValidateFunctions>()
                              .validationOfEmail(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: email,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      validator:
                          (value) => getIt<ValidateFunctions>()
                              .validationOfPhoneNumber(value),
                      controller: phoneNumber,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        labelText: 'Phone number',
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      obscuringCharacter: '*',
                      validator:
                          (value) => getIt<ValidateFunctions>()
                              .validationOfPassword(value),
                      controller: password,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        suffix: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const ChangePasswordScreen(),
                              ),
                            );
                          },
                          child: const Text('Change'),
                        ),
                        suffixStyle: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Gender',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.006),
                        Expanded(
                          child: IgnorePointer(
                            ignoring: true,
                            child: RadioListTile<Gender>(
                              activeColor: AppColors.mainColor,
                              title: const Text('Female'),
                              value: Gender.female,
                              groupValue: _selectedIndex,
                              contentPadding: EdgeInsets.zero,
                              onChanged:
                                  (value) => _onGenderChanged(value, state),
                            ),
                          ),
                        ),
                        Expanded(
                          child: IgnorePointer(
                            ignoring: true,
                            child: RadioListTile<Gender>(
                              activeColor: AppColors.mainColor,
                              title: const Text('Male'),
                              value: Gender.male,
                              groupValue: _selectedIndex,
                              contentPadding: EdgeInsets.zero,
                              onChanged:
                                  (value) => _onGenderChanged(value, state),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          isDirty
                              ? () {
                                editProfileViewModel.onIntent(
                                  EditInfo(
                                    firstName.text,
                                    lastName.text,
                                    email.text,
                                    phoneNumber.text,
                                  ),
                                );
                              }
                              : null,
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum Gender { male, female }
