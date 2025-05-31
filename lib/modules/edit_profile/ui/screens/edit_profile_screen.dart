import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../core/di/injectable_initializer.dart';
import '../../../../core/validation/validation_functions.dart';
import '../cubit/states.dart';
import '../cubit/viewModel.dart';

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

  EditProfileViewModel editProfileViewModel =
  getIt.get<EditProfileViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    editProfileViewModel.onIntent(EditProfileIntent()); // call to fetch and emit data

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context) => editProfileViewModel,

      child: BlocConsumer<EditProfileViewModel, ProfileState>(
        listener: (context, state) {
          // If you only want to update once when data is fetched:
          if (state.getProfileDataStatus == EditProfileStatus.success) {
            firstName.text = state.firstName ?? '';
            lastName.text = state.lastName ?? '';
            email.text = state.email ?? '';
            phoneNumber.text = state.phoneNumber ?? '';
            password.text=state.password??'';
            // Don't prefill password
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage(AssetsPaths.profileIcon),
                          radius: 30,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            validator:
                                (value) =>
                                getIt<ValidateFunctions>().validationOfFullName(value),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: firstName,
                            decoration: const InputDecoration(
                              enabled: true,
                              hintText: 'First Name',
                              labelText: 'First name',
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator:
                                (value) =>
                                getIt<ValidateFunctions>().validationOfFullName(value),
                            controller: lastName,
                            decoration: const InputDecoration(
                              enabled: true,
                              hintText: 'Last Name',
                              labelText: 'Last name',
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      validator:
                          (value) =>
                          getIt<ValidateFunctions>().validationOfEmail(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: email,
                      decoration: const InputDecoration(
                        enabled: true,
                        hintText: 'Email',
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      validator:
                          (value) =>
                          getIt<ValidateFunctions>().validationOfPhoneNumber(value),
                      controller: phoneNumber,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        enabled: true,
                        hintText: 'Phone Number',
                        labelText: 'Phone number',
                      ),
                    ),
                    TextFormField(
                      validator:
                          (value) =>
                          getIt<ValidateFunctions>().validationOfPassword(value),
                      controller: password,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscuringCharacter: '*',
                      obscureText: true,
                      decoration: const InputDecoration(
                        enabled: true,
                        hintText: 'Password',
                        labelText: 'Password',
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
                          child: RadioListTile<Gender>(
                            title: const Text('Female'),
                            value: Gender.female,
                            groupValue: _selectedIndex,
                            onChanged: (value) {
                              setState(() {
                                _selectedIndex = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<Gender>(
                            title: const Text('Male'),
                            value: Gender.male,
                            groupValue: _selectedIndex,
                            onChanged: (value) {
                              setState(() {
                                _selectedIndex = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text('Update')),
                  ],
                ),
              ),
            ),
          );
        },
      ),);

  }
}

enum Gender { male, female, other }
