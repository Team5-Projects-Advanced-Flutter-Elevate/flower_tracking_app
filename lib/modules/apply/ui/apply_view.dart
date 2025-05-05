import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/apply/ui/view_model/apply_cubit.dart';
import 'package:flower_tracking_app/modules/apply/ui/widgets/apply_text_form_fields.dart';
import 'package:flower_tracking_app/modules/apply/ui/widgets/select_gender_row.dart';
import 'package:flutter/material.dart';

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
        body: Padding(
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
                  ApplyTextFormFields(formKey: _formKey),

                  // continue button
                ],
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
