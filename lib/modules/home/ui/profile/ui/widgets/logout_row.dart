import 'package:flutter/material.dart';
import '../../../../../../core/bases/base_inherited_widget.dart';
import '../../../../../../core/bases/base_statless_widget.dart';
import '../../../../../../core/colors/app_colors.dart';

class LogoutRow extends BaseStatelessWidget {
  const LogoutRow({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Row(
      children: [
        const Icon(Icons.logout, size: 20),
        SizedBox(width: inherit.screenWidth * 0.01),
        Text('Logout', style: inherit.theme.textTheme.bodyMedium),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.logout, size: 30, color: AppColors.gray),
        ),
      ],
    );
  }
}
