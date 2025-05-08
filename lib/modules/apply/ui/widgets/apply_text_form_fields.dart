import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
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
    return BlocConsumer<ApplyCubit, ApplyState>(
      listener: (context, state) {
        if (state.applyDriverStatus == ApplyDriverStatus.success) {
          /// navigate to apply successfully screen
        }
      },
      builder: (context, state) {
        switch (state.loadApplyDataStatus) {
          case LoadApplyDataStatus.initial:
          case LoadApplyDataStatus.loading:
            return SizedBox(
              height: screenHeight * 0.6,
              child: const LoadingStateWidget(),
            );
          case LoadApplyDataStatus.success:
            return Column(
              children: [
                CustomDropDown(
                  onChanged: (val) {
                    cubit.doIntent(SelectCountryIntent(val));
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
                CustomDropDown<VehicleEntity>(
                  onChanged: (val) {
                    cubit.doIntent(SelectVehicleIntent(val));
                  },
                  items:
                      state.vehicles!
                          .map(
                            (vehicle) => DropdownMenuItem<VehicleEntity>(
                              value: vehicle,
                              child: Text(vehicle.type ?? ''),
                            ),
                          )
                          .toList(),
                  label: 'Vehicle type',
                  value: cubit.state.selectedVehicle ?? state.vehicles?.first,
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: vehicleNumberController,

                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  focusNode: vehicleNumberFocusNode,
                  onFieldSubmitted:
                      (value) => vehicleLicenseFocusNode.requestFocus(),
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
                              cubit.doIntent(PickLicenseImageIntent());
                            } else {
                              cubit.doIntent(UnPickImageIntent(true));
                            }
                          },
                          // icon: Icon(Icons.ios_share),
                          icon:
                              !state.isLicenseImagePicked!
                                  ? const ImageIcon(
                                    AssetImage(AssetsPaths.shareIcon),
                                  )
                                  : const Icon(Icons.close),
                        ),
                        prefixIcon:
                            !state.isLicenseImagePicked!
                                ? null
                                : Icon(Icons.image, color: AppColors.mainColor),
                        labelText: 'Vehicle license',
                        hintText:
                            !state.isLicenseImagePicked!
                                ? 'Upload license photo'
                                : '',
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
                    hintText: 'Enter email',
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
                    } else if (val.length < 14) {
                      return "ID number must be 14 characters ";
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
                      onFieldSubmitted:
                          (value) => passwordFocusNode.requestFocus(),
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
                              cubit.doIntent(PickIdImageIntent());
                            } else {
                              cubit.doIntent(UnPickImageIntent(false));
                            }
                          },
                          icon:
                              !state.isIdImagePicked!
                                  ? const ImageIcon(
                                    AssetImage(AssetsPaths.shareIcon),
                                  )
                                  : const Icon(Icons.close),
                        ),
                        labelText: 'ID image',
                        prefixIcon:
                            !state.isIdImagePicked!
                                ? null
                                : Icon(Icons.image, color: AppColors.mainColor),
                        hintText:
                            !state.isIdImagePicked! ? 'UploadID image' : '',
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
                          return validateFunctions.validationOfPassword(
                            inputText,
                          );
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        focusNode: passwordFocusNode,
                        onFieldSubmitted:
                            (value) => confirmPasswordFocusNode.requestFocus(),
                        obscureText: true,
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
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        focusNode: confirmPasswordFocusNode,
                        onFieldSubmitted:
                            (value) => confirmPasswordFocusNode.unfocus(),
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

                BlocBuilder<ApplyCubit, ApplyState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          if (state.selectedGender == null) {
                            displaySnackBar(
                              contentType: ContentType.failure,
                              title: 'Error',
                              message: 'Please select gender',
                            );
                            return;
                          }
                          if (!widget.formKey.currentState!.validate()) return;

                          cubit.doIntent(
                            ApplyDriverIntent(
                              DriverRequestModel(
                                country:
                                    cubit.state.selectedCountry ??
                                    cubit.state.countries.first.name,
                                vehicleType:
                                    cubit.state.selectedVehicle?.id ??
                                    cubit.state.vehicles?.first.id,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                vehicleNumber: vehicleNumberController.text,
                                vehicleLicense: cubit.state.pickedLicenseImage,
                                nid: idNumberController.text,
                                nIDImg: cubit.state.pickedIdImage,
                                email: emailController.text,
                                password: passwordController.text,
                                rePassword: confirmPasswordController.text,
                                gender: cubit.state.selectedGender,
                              ),
                            ),
                          );
                        },
                        child:
                            state.applyDriverStatus == ApplyDriverStatus.loading
                                ? CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                                : const Text('Continue'),
                      ),
                    );
                  },
                ),
              ],
            );
          case LoadApplyDataStatus.error:
            return ErrorStateWidget(
              error:
                  state.loadVehicleError != null
                      ? state.loadVehicleError!
                      : state.loadCountryError!,
            );
        }
      },
    );
  }

  void clearControllers() {
    firstNameController.clear();
    lastNameController.clear();
    vehicleNumberController.clear();
    vehicleLicenseController.clear();
    emailController.clear();
    idNumberController.clear();
    idImageController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
