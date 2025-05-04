import 'package:country_flags/country_flags.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/widgets/error_state_widget.dart';
import 'package:flower_tracking_app/core/widgets/loading_state_widget.dart';
import 'package:flower_tracking_app/modules/apply/ui/view_model/apply_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/assets_paths/assets_paths.dart';

class ApplyView extends StatefulWidget {
  const ApplyView({super.key});

  @override
  State<ApplyView> createState() => _ApplyViewState();
}

class _ApplyViewState extends BaseStatefulWidgetState<ApplyView> {
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

  String? selectedCountry;
  String? selectedVehicle;
  String selectedGender = 'Female';

  List<String> vehicles = ['Car', 'Motorcycle', 'Bicycle'];
  ApplyCubit cubit = getIt<ApplyCubit>();
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

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
    return GestureDetector(
      onTap: () => unFocusKeyboard(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title: Text(
            "Apply",
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 20 * (screenWidth / 375),
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) => cubit..loadCountries(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome!!',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 16 * (screenWidth / 375),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'You want to be a delivery man? \n join our team',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.gray,
                        fontSize: 12 * (screenWidth / 375),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    BlocBuilder<ApplyCubit, ApplyState>(
                      builder: (context, state) {
                        switch (state.loadCountryStatus) {
                          case LoadCountryStatus.initial:
                          case LoadCountryStatus.loading:
                            return const LoadingStateWidget();
                          case LoadCountryStatus.success:
                            return CustomDropDown(
                              onChanged: (val) {
                                setState(() {
                                  selectedCountry = val;
                                });
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
                                                SizedBox(
                                                  width: screenWidth * 0.03,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    country.name ?? '',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                              value: selectedCountry ?? state.countries[64].name,
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
                      onFieldSubmitted:
                          (value) => lastNameFocusNode.requestFocus(),
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
                        setState(() {
                          selectedVehicle = val;
                        });
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
                      value: selectedVehicle ?? vehicles[0],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: vehicleNumberController,

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      focusNode: vehicleNumberFocusNode,
                      onFieldSubmitted:
                          (value) => vehicleLicenseFocusNode.requestFocus(),
                      decoration: const InputDecoration(
                        labelText: 'Vehicle number',
                        hintText: 'Enter vehicle number',
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: vehicleLicenseController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: vehicleNumberFocusNode,
                      onFieldSubmitted:
                          (value) => vehicleLicenseFocusNode.requestFocus(),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.ios_share),
                          // icon: const ImageIcon( AssetImage(AssetsPaths.shareIcon)),
                        ),
                        labelText: 'Vehicle license',
                        hintText: 'Upload license photo',
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: emailController,
                      validator: (inputText) {
                        return validateFunctions.validationOfFirstOrLastName(
                          inputText,
                          isFirstName: false,
                        );
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      onFieldSubmitted:
                          (value) => idImageFocusNode.requestFocus(),
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
                      onFieldSubmitted:
                          (value) => idImageFocusNode.requestFocus(),
                      decoration: const InputDecoration(
                        labelText: 'ID number',
                        hintText: 'Enter national ID number',
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: idImageController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: idImageFocusNode,
                      onFieldSubmitted:
                          (value) => passwordFocusNode.requestFocus(),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.ios_share),
                          // icon: const ImageIcon( AssetImage(AssetsPaths.shareIcon)),
                        ),
                        labelText: 'ID image',
                        hintText: 'UploadID image',
                      ),
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
                                (value) =>
                                    confirmPasswordFocusNode.requestFocus(),
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
                              return validateFunctions
                                  .validationOfConfirmPassword(
                                    inputText,
                                    passwordController.text,
                                  );
                            },
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

                    Row(
                      children: [
                        Text(
                          'Gender',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontSize: 18,
                            color: AppColors.white[90],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  contentPadding: EdgeInsets.zero,
                                  hoverColor: AppColors.transparent,
                                  title: Text(
                                    'Female',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color:
                                          selectedGender == 'Female'
                                              ? AppColors.black
                                              : AppColors.white[90],
                                    ),
                                  ),
                                  value: 'Female',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value ?? selectedGender;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    'Male',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color:
                                          selectedGender == 'Male'
                                              ? AppColors.black
                                              : AppColors.white[90],
                                    ),
                                  ),
                                  value: 'Male',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value ?? selectedGender;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    SizedBox(
                      width: double.infinity,
                        child: FilledButton(onPressed: () {}, child: Text('Continue'))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void unFocusKeyboard() {
    FocusScope.of(context).unfocus();
  }
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.items,
    this.onChanged,
    required this.label,
    required this.value,
  });

  final List<DropdownMenuItem<String?>> items;
  final void Function(String?)? onChanged;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String?>(
      value: value,
      items: items,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyMedium,
      dropdownStyleData: DropdownStyleData(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.6, // <-- Custom width
        offset: const Offset(0, -5), // <-- Custom position
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      iconStyleData: IconStyleData(
        icon: ImageIcon(
          const AssetImage(AssetsPaths.dropDownIcon),
          color: AppColors.gray,
          size: 20,
        ),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        label: Text(label),
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.gray,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: AppColors.mainColor, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: AppColors.gray),
        ),
      ),
    );
  }
}
