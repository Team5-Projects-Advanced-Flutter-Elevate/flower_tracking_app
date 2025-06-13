import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flower_tracking_app/core/apis/api_error/api_error_handler.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/core/routing/defined_routes.dart';
import 'package:flower_tracking_app/modules/edit_vehicle_info/ui/view_model/vehicle_cubit.dart';
import 'package:flower_tracking_app/modules/edit_vehicle_info/ui/widgets/edit_vehicle_text_form_fields.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditVehicleInfoScreen extends StatefulWidget {
  const EditVehicleInfoScreen({super.key});

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
    cubit.doIntent(GetVehicleByIdIntent('676b63ef9f3884b3405c14a5'));

    BackButtonInterceptor.add(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.pushReplacementNamed(
      context,
      DefinedRoutes.onboardingScreenRoute,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: GestureDetector(
        onTap: () => unFocusKeyboard(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  DefinedRoutes.onboardingScreenRoute,
                );
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
                Navigator.pushNamed(context, DefinedRoutes.loginScreenRoute);
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
                      formKey: _formKey,
                      whenApplySuccess: () async {
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                        await Navigator.pushReplacementNamed(
                          context,
                          DefinedRoutes.applicationApproved,
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

  void unFocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    BackButtonInterceptor.remove(myInterceptor);
  }
}
