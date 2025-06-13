import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/widgets/error_state_widget.dart';
import 'package:flower_tracking_app/core/widgets/loading_state_widget.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/viewModel/profile_cubit.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/widgets/language_row.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/widgets/logout_row.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/widgets/user_card.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/widgets/vehicle_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../shared_layers/localization/enums/languages_enum.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseStatefulWidgetState<ProfileScreen> {
  ProfileCubit profileCubit = getIt<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    profileCubit.doIntent(LoadProfileIntent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(
            left:
                localizationManager.currentLocale ==
                        LanguagesEnum.ar.getLanguageCode()
                    ? 0
                    : 24,
            right:
                localizationManager.currentLocale ==
                        LanguagesEnum.ar.getLanguageCode()
                    ? 24
                    : 0,
          ),
          child: Text(appLocalizations.profile),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                right:
                    localizationManager.currentLocale ==
                            LanguagesEnum.ar.getLanguageCode()
                        ? 0
                        : 24,
                left:
                    localizationManager.currentLocale ==
                            LanguagesEnum.ar.getLanguageCode()
                        ? 24
                        : 0,
              ),
              child: SvgPicture.asset(AssetsPaths.notificationIcon),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          switch (state.loadProfileStatus) {
            case LoadProfileStatus.initial:
            case LoadProfileStatus.loading:
              return const LoadingStateWidget();
            case LoadProfileStatus.success:
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    UserCard(state.loggedDriverDataResponseEntity!),
                    SizedBox(height: screenHeight * 0.03),
                    VehicleInfoCard(state.loggedDriverDataResponseEntity!),
                    SizedBox(height: screenHeight * 0.03),
                    const LanguageRow(),
                    SizedBox(height: screenHeight * 0.01),
                    const LogoutRow(),
                  ],
                ),
              );
            case LoadProfileStatus.error:
              return ErrorStateWidget(error: state.loadProfileError!);
          }
        },
      ),
    );
  }
}
