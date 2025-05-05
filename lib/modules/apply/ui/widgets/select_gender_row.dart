import 'dart:developer';

import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/apply/ui/view_model/apply_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../core/colors/app_colors.dart';

class SelectGenderRow extends StatefulWidget {
  const SelectGenderRow({super.key});

  @override
  State<SelectGenderRow> createState() => _SelectGenderRowState();
}

class _SelectGenderRowState extends BaseStatefulWidgetState<SelectGenderRow> {
  ApplyCubit cubit = getIt<ApplyCubit>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Gender',
          style: theme.textTheme.labelMedium?.copyWith(
            fontSize: 18,
            color: AppColors.white[90],
          ),
        ),
        BlocBuilder<ApplyCubit, ApplyState>(
          builder: (context, state) {
            return Expanded(
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
                              state.selectedGender == 'Female'
                                  ? AppColors.black
                                  : AppColors.white[90],
                        ),
                      ),
                      value: 'Female',
                      groupValue: state.selectedGender,
                      onChanged: (value) {
                        cubit.selectGender(value);
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
                              cubit.state.selectedGender == 'Male'
                                  ? AppColors.black
                                  : AppColors.white[90],
                        ),
                      ),
                      value: 'Male',
                      groupValue: cubit.state.selectedGender,
                      onChanged: (value) {
                        cubit.selectGender(value);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
