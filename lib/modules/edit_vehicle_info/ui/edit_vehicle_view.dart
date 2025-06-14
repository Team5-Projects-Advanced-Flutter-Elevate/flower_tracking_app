import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/core/apis/api_error/api_error_handler.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/edit_vehicle_info/ui/view_model/vehicle_cubit.dart';
import 'package:flower_tracking_app/modules/edit_vehicle_info/ui/widgets/edit_vehicle_text_form_fields.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/edite_profile_response.dart';

class EditVehicleInfoScreen extends StatefulWidget {
  const EditVehicleInfoScreen({super.key, required this.editVehicleRequest});

  final EditVehicleRequest editVehicleRequest;

  @override
  State<EditVehicleInfoScreen> createState() => _EditVehicleInfoScreenState();
}

class _EditVehicleInfoScreenState
    extends BaseStatefulWidgetState<EditVehicleInfoScreen> {
  VehicleCubit cubit = getIt<VehicleCubit>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cubit.doIntent(LoadVehiclesIntent());
    cubit.doIntent(
      GetVehicleByIdIntent(widget.editVehicleRequest.vehicleType ?? ''),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
            title: Text(
              AppLocalizations.of(context)!.editProfile,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 20 * (screenWidth / 375),
              ),
            ),
          ),
          body: BlocListener<VehicleCubit, VehicleState>(
            listener: (context, state) {
              if (state.editVehicleStatus == EditeVehicleStatus.success) {
                Navigator.pop(context);
              }
              if (state.editVehicleStatus == EditeVehicleStatus.error) {
                displaySnackBar(
                  contentType: ContentType.failure,
                  title: AppLocalizations.of(context)!.error,
                  message: getIt<ApiErrorHandler>().handle(
                    state.editVehicleError!,
                  ),
                );
              }
              if (state.pickImageStatus == PickImageStatus.success) {
                displaySnackBar(
                  contentType: ContentType.success,
                  title: AppLocalizations.of(context)!.imagePickedSuccess,
                );
              } else if (state.pickImageStatus == PickImageStatus.error) {
                displaySnackBar(
                  contentType: ContentType.failure,
                  title: AppLocalizations.of(context)!.imagePickFailed,
                );
              }
              if (state.pickImageStatus == PickImageStatus.unPicked) {
                displaySnackBar(
                  contentType: ContentType.failure,
                  title: AppLocalizations.of(context)!.removedImage,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VehicleTextFormFields(
                      editVehicleRequest: widget.editVehicleRequest,
                      formKey: _formKey,
                      whenUpdatedSuccess: () async {
                        displaySnackBar(
                          contentType: ContentType.success,
                          title: 'Profile updated successfully',
                        );
                      },
                    ),

                    // continue button
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
