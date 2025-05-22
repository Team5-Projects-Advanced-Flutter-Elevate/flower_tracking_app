import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/viewModel/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/bases/base_inherited_widget.dart';
import '../../../../../../core/bases/base_statless_widget.dart';
import '../../../../../../core/colors/app_colors.dart';
import '../../../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../../../shared_layers/localization/enums/languages_enum.dart';
import '../../../../../../shared_layers/localization/l10n_manager/localization_manager.dart';

class LanguageRow extends BaseStatelessWidget {
  const LanguageRow({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Row(
      children: [
        SvgPicture.asset(AssetsPaths.languageIcon),
        SizedBox(width: inherit.screenWidth * 0.01),
        Text(
          inherit.appLocalizations.language,
          style: inherit.theme.textTheme.bodyMedium,
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            final newLocale =
                inherit.localizationManager.currentLocale ==
                        LanguagesEnum.en.getLanguageCode()
                    ? LanguagesEnum.ar.getLanguageCode()
                    : LanguagesEnum.en.getLanguageCode();

            inherit.localizationManager.changeLocal(newLocale);
          },
          child: Text(
            inherit.appLocalizations.english,
            style: inherit.theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.mainColor,
            ),
          ),
        ),
      ],
    );
  }
}
