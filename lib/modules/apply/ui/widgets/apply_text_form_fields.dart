import 'package:country_flags/country_flags.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/apply/ui/widgets/select_gender_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_state_widget.dart';
import '../../data/models/apply_response.dart';
import '../view_model/apply_cubit.dart';
import 'custom_drop_down.dart';

class ApplyTextFormFields extends StatefulWidget {
  const ApplyTextFormFields({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<ApplyTextFormFields> createState() => _ApplyTextFormFieldsState();
}

class _ApplyTextFormFieldsState
    extends BaseStatefulWidgetState<ApplyTextFormFields> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController vehicleNumberController;
  late TextEditingController vehicleLicenseController;
  late TextEditingController emailController;
  late TextEditingController idNumberController;
  late TextEditingController idImageController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  late FocusNode firstNameFocusNode;
  late FocusNode lastNameFocusNode;
  late FocusNode vehicleNumberFocusNode;
  late FocusNode vehicleLicenseFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode idNumberFocusNode;
  late FocusNode idImageFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  List<String> vehicles = ['Car', 'Motorcycle', 'Bicycle'];

  ApplyCubit cubit = getIt<ApplyCubit>();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    vehicleNumberController = TextEditingController();
    vehicleLicenseController = TextEditingController();
    emailController = TextEditingController();
    idNumberController = TextEditingController();
    idImageController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    vehicleNumberFocusNode = FocusNode();
    vehicleLicenseFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    idNumberFocusNode = FocusNode();
    idImageFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    vehicleNumberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    idNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    vehicleNumberFocusNode.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    idNumberFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ApplyCubit, ApplyState>(
          builder: (context, state) {
            switch (state.loadCountryStatus) {
              case LoadCountryStatus.initial:
              case LoadCountryStatus.loading:
                return const LoadingStateWidget();
              case LoadCountryStatus.success:
                return CustomDropDown(
                  onChanged: (val) {
                    cubit.selectCountry(val);
                  },
                  items:
                      state.countries
                          .map(
                            (country) => DropdownMenuItem<String>(
                              value: country.name,
                              child: SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    CountryFlag.fromCountryCode(
                                      country.isoCode!,
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(width: screenWidth * 0.03),
                                    Expanded(
                                      child: Text(
                                        country.name ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  label: 'Country',
                  value:
                      cubit.state.selectedCountry ?? state.countries[64].name,
                );
              case LoadCountryStatus.error:
                return ErrorStateWidget(error: state.error!);
            }
          },
        ),
        SizedBox(height: screenHeight * 0.02),
        TextFormField(
          controller: firstNameController,
          validator: (inputText) {
            return validateFunctions.validationOfFirstOrLastName(
              inputText,
              isFirstName: true,
            );
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          focusNode: firstNameFocusNode,
          onFieldSubmitted: (value) => lastNameFocusNode.requestFocus(),
          decoration: const InputDecoration(
            labelText: 'First legal name',
            hintText: 'Enter your first legal name',
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        TextFormField(
          controller: lastNameController,
          validator: (inputText) {
            return validateFunctions.validationOfFirstOrLastName(
              inputText,
              isFirstName: false,
            );
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          focusNode: lastNameFocusNode,

          decoration: const InputDecoration(
            labelText: 'Second legal name',
            hintText: 'Enter your second legal name',
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        CustomDropDown(
          onChanged: (val) {
            cubit.selectVehicle(val);
          },
          items:
              vehicles
                  .map(
                    (vehicle) => DropdownMenuItem<String>(
                      value: vehicle,
                      child: Text(vehicle),
                    ),
                  )
                  .toList(),
          label: 'Vehicle type',
          value: cubit.state.selectedVehicle ?? vehicles[0],
        ),
        SizedBox(height: screenHeight * 0.02),
        TextFormField(
          controller: vehicleNumberController,

          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.number,
          focusNode: vehicleNumberFocusNode,
          onFieldSubmitted: (value) => vehicleLicenseFocusNode.requestFocus(),
          validator: (val) {
            if (val!.isEmpty) {
              return 'Please enter vehicle number';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Vehicle number',
            hintText: 'Enter vehicle number',
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        BlocBuilder<ApplyCubit, ApplyState>(
          builder: (context, state) {
            return TextFormField(
              controller: vehicleLicenseController,
              readOnly: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              focusNode: vehicleLicenseFocusNode,
              onFieldSubmitted:
                  (value) => vehicleLicenseFocusNode.requestFocus(),
              validator: (val) {
                if (!state.isLicenseImagePicked!) {
                  return 'Please upload vehicle license';
                }
                return null;
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    if (!state.isLicenseImagePicked!) {
                      cubit.pickLicenseImage();
                    } else {
                      cubit.unPickImage(true);
                    }
                  },
                  // icon: Icon(Icons.ios_share),
                  icon:
                      !state.isLicenseImagePicked!
                          ? const ImageIcon(AssetImage(AssetsPaths.shareIcon))
                          : const Icon(Icons.close),
                ),
                prefixIcon:
                    !state.isLicenseImagePicked!
                        ? null
                        : Icon(Icons.image, color: AppColors.mainColor),
                labelText: 'Vehicle license',
                hintText:
                    !state.isLicenseImagePicked! ? 'Upload license photo' : '',
              ),
            );
          },
        ),
        SizedBox(height: screenHeight * 0.02),
        TextFormField(
          controller: emailController,
          validator: (inputText) {
            return validateFunctions.validationOfEmail(inputText);
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          focusNode: emailFocusNode,
          onFieldSubmitted: (value) => idImageFocusNode.requestFocus(),
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'Enter phone number',
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        TextFormField(
          controller: idNumberController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.number,
          focusNode: idNumberFocusNode,
          onFieldSubmitted: (value) => idImageFocusNode.requestFocus(),
          validator: (val) {
            if (val!.isEmpty) {
              return 'Please enter ID number';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'ID number',
            hintText: 'Enter national ID number',
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        BlocBuilder<ApplyCubit, ApplyState>(
          builder: (context, state) {
            return TextFormField(
              readOnly: true,
              controller: idImageController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              focusNode: idImageFocusNode,
              onFieldSubmitted: (value) => passwordFocusNode.requestFocus(),
              validator: (val) {
                if (!state.isIdImagePicked!) {
                  return 'Please upload ID image';
                }
                return null;
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    if (!state.isIdImagePicked!) {
                      cubit.pickIdImage();
                    } else {
                      cubit.unPickImage(false);
                    }
                  },
                  icon:
                      !state.isIdImagePicked!
                          ? const ImageIcon(AssetImage(AssetsPaths.shareIcon))
                          : const Icon(Icons.close),
                ),
                labelText: 'ID image',
                prefixIcon:
                    !state.isIdImagePicked!
                        ? null
                        : Icon(Icons.image, color: AppColors.mainColor),
                hintText: !state.isIdImagePicked! ? 'UploadID image' : '',
              ),
            );
          },
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: passwordController,
                validator: (inputText) {
                  return validateFunctions.validationOfPassword(inputText);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.visiblePassword,
                focusNode: passwordFocusNode,
                onFieldSubmitted:
                    (value) => confirmPasswordFocusNode.requestFocus(),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter password',
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: TextFormField(
                controller: confirmPasswordController,
                validator: (inputText) {
                  return validateFunctions.validationOfConfirmPassword(
                    inputText,
                    passwordController.text,
                  );
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.visiblePassword,
                focusNode: confirmPasswordFocusNode,
                onFieldSubmitted: (value) => confirmPasswordFocusNode.unfocus(),
                decoration: InputDecoration(
                  label: Text(
                    'Confirm password',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.gray,
                      fontSize: 12 * (screenWidth / 375),
                    ),
                  ),
                  hintText: 'Confirm password',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
        const SelectGenderRow(),
        SizedBox(height: screenHeight * 0.02),

        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () async {
              if (!widget.formKey.currentState!.validate()) return;
              cubit.applyDriver(
                DriverRequestModel(
                  country: cubit.state.selectedCountry,
                  vehicleType: cubit.state.selectedVehicle,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  vehicleNumber: vehicleNumberController.text,
                  vehicleLicense: cubit.state.pickedLicenseImage,
                  nid: vehicleNumberController.text,
                  nIDImg: cubit.state.pickedIdImage,
                  email: emailController.text,
                  password: passwordController.text,
                  rePassword: confirmPasswordController.text,
                  gender: cubit.state.selectedGender,
                ),
              );
            },
            child: Text('Continue'),
          ),
        ),
      ],
    );
  }
}
