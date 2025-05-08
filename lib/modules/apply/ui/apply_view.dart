import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/core/apis/api_error/api_error_handler.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/apply/ui/view_model/apply_cubit.dart';
import 'package:flower_tracking_app/modules/apply/ui/widgets/apply_text_form_fields.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyView extends StatefulWidget {
  const ApplyView({super.key});

  @override
  State<ApplyView> createState() => _ApplyViewState();
}

class _ApplyViewState extends BaseStatefulWidgetState<ApplyView> {
  ApplyCubit cubit = getIt<ApplyCubit>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocusKeyboard(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title: Text(
            AppLocalizations.of(context)!.apply,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 20 * (screenWidth / 375),
            ),
          ),
        ),
        body: BlocListener<ApplyCubit, ApplyState>(
          listener: (context, state) {
            if (state.applyDriverStatus == ApplyDriverStatus.success) {
              displaySnackBar(
                contentType: ContentType.success,
                title: 'success',
              );
            }
            if (state.applyDriverStatus == ApplyDriverStatus.error) {
              displaySnackBar(
                contentType: ContentType.failure,
                title: AppLocalizations.of(context)!.error,
                message: getIt<ApiErrorHandler>().handle(
                  state.applyDriverError!,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcome,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 16 * (screenWidth / 375),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      '${AppLocalizations.of(context)!.joinQuestion} \n ${AppLocalizations.of(context)!.joinOurTeam}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.gray,
                        fontSize: 12 * (screenWidth / 375),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    ApplyTextFormFields(formKey: _formKey),

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
    FocusScope.of(context).unfocus();
  }
}
