import 'package:flower_tracking_app/modules/edit_vehicle_info/data/models/edite_profile_response.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_state_widget.dart';
import '../../domain/entities/vehicle_response_entity.dart';
import '../view_model/vehicle_cubit.dart';
import 'custom_drop_down.dart';

class VehicleTextFormFields extends StatefulWidget {
  const VehicleTextFormFields({
    super.key,
    required this.formKey,
    required this.whenUpdatedSuccess,
    required this.editVehicleRequest,
  });

  final GlobalKey<FormState> formKey;
  final void Function() whenUpdatedSuccess;
  final EditVehicleRequest editVehicleRequest;

  @override
  State<VehicleTextFormFields> createState() => _VehicleTextFormFieldsState();
}

class _VehicleTextFormFieldsState
    extends BaseStatefulWidgetState<VehicleTextFormFields> {
  late TextEditingController vehicleNumberController;
  late TextEditingController vehicleLicenseController;

  late FocusNode vehicleNumberFocusNode;
  late FocusNode vehicleLicenseFocusNode;
  bool en = false;

  @override
  void initState() {
    super.initState();

    vehicleNumberController = TextEditingController(
      text: widget.editVehicleRequest.vehicleNumber,
    );
    vehicleLicenseController = TextEditingController();

    vehicleNumberFocusNode = FocusNode();
    vehicleLicenseFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    vehicleNumberController.dispose();

    vehicleNumberFocusNode.dispose();
  }

  late VehicleCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of<VehicleCubit>(context);
    return BlocConsumer<VehicleCubit, VehicleState>(
      listener: (context, state) {
        if (state.editVehicleStatus == EditeVehicleStatus.success) {
          /// navigate to apply successfully screen

          widget.whenUpdatedSuccess();
        }
      },
      builder: (context, state) {
        switch (state.loadVehicleStatus) {
          case LoadVehicleStatus.initial:
          case LoadVehicleStatus.loading:
            return SizedBox(
              height: screenHeight * 0.6,
              child: const LoadingStateWidget(),
            );
          case LoadVehicleStatus.success:
            return Expanded(
              child: Column(
                children: [
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
                        return AppLocalizations.of(
                          context,
                        )!.vehicleNumberPrompt;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.vehicleNumber,
                      hintText: AppLocalizations.of(context)!.vehicleNumberHint,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  BlocBuilder<VehicleCubit, VehicleState>(
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
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (!state.isLicenseImagePicked!) {
                                showSheet(true);
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
                                  : Icon(
                                    Icons.image,
                                    color: AppColors.mainColor,
                                  ),
                          labelText:
                              AppLocalizations.of(context)!.vehicleLicense,
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
                  const Spacer(),
                  BlocBuilder<VehicleCubit, VehicleState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (!widget.formKey.currentState!.validate()) {
                              return;
                            }

                            cubit.doIntent(
                              EditVehicleIntent(
                                EditVehicleRequest(
                                  vehicleLicense: state.pickedLicenseImage,
                                  vehicleNumber: vehicleNumberController.text,
                                  vehicleType:
                                      cubit.state.selectedVehicle?.type,
                                ),
                              ),
                            );
                          },
                          child:
                              state.editVehicleStatus ==
                                      EditeVehicleStatus.loading
                                  ? CircularProgressIndicator(
                                    color: AppColors.white,
                                  )
                                  : Text(AppLocalizations.of(context)!.update),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),
                ],
              ),
            );
          case LoadVehicleStatus.error:
            return ErrorStateWidget(error: state.loadVehicleError!);
        }
      },
    );
  }

  Future<void> showSheet(bool isLicense) => showModalBottomSheet(
    context: context,
    builder:
        (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: AppColors.mainColor),
                title: const Text('Take Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  isLicense
                      ? cubit.doIntent(
                        PickLicenseImageIntent(ImageSource.camera),
                      )
                      : cubit.doIntent(PickImageIntent(ImageSource.camera));
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  isLicense
                      ? cubit.doIntent(
                        PickLicenseImageIntent(ImageSource.gallery),
                      )
                      : cubit.doIntent(PickImageIntent(ImageSource.gallery));
                },
              ),
            ],
          ),
        ),
  );
}
