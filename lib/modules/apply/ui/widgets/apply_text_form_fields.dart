import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/ui/widgets/select_gender_row.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
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
                  label: AppLocalizations.of(context)!.country,
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
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.firstName,
                    hintText: AppLocalizations.of(context)!.firstNameHint,
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

                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.secondName,
                    hintText: AppLocalizations.of(context)!.secondNameHint,
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
                  label: AppLocalizations.of(context)!.vehicleType,
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
                      return AppLocalizations.of(context)!.vehicleNumberPrompt;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.vehicleNumber,
                    hintText: AppLocalizations.of(context)!.vehicleNumberHint,
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
                          return AppLocalizations.of(
                            context,
                          )!.vehicleLicensePrompt;
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
                        labelText: AppLocalizations.of(context)!.vehicleLicense,
                        hintText:
                            !state.isLicenseImagePicked!
                                ? AppLocalizations.of(
                                  context,
                                )!.vehicleLicenseHint
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
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                    hintText: AppLocalizations.of(context)!.emailHint,
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
                      return AppLocalizations.of(context)!.idNumberPrompt;
                    } else if (val.length < 14) {
                      return AppLocalizations.of(context)!.idNumberLength;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.idNumber,
                    hintText: AppLocalizations.of(context)!.idNumberHint,
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
                          return AppLocalizations.of(context)!.idImagePrompt;
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
                        labelText: AppLocalizations.of(context)!.idImage,
                        prefixIcon:
                            !state.isIdImagePicked!
                                ? null
                                : Icon(Icons.image, color: AppColors.mainColor),
                        hintText:
                            !state.isIdImagePicked!
                                ? AppLocalizations.of(context)!.idImageHint
                                : '',
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
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password,
                          hintText: AppLocalizations.of(context)!.passwordHint,
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
                            AppLocalizations.of(context)!.confirmPassword,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.gray,
                              fontSize: 12 * (screenWidth / 375),
                            ),
                          ),
                          hintText:
                              AppLocalizations.of(context)!.confirmPasswordHint,
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
                              title: AppLocalizations.of(context)!.error,
                              message:
                                  AppLocalizations.of(context)!.selectGender,
                            );
                          }
                          if (!widget.formKey.currentState!.validate()) {
                            return;
                          }
                          if(state.selectedGender == null) return;

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
                                : Text(
                                  AppLocalizations.of(context)!.continueButton,
                                ),
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
