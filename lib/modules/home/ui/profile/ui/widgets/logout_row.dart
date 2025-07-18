import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flower_tracking_app/core/routing/defined_routes.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/viewModel/profile_cubit.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/bases/base_inherited_widget.dart';
import '../../../../../../core/bases/base_statless_widget.dart';
import '../../../../../../core/colors/app_colors.dart';

class LogoutRow extends BaseStatelessWidget {
  const LogoutRow({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    ProfileCubit profileCubit = BlocProvider.of(context);
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.logoutStatus == LogoutStatus.loading) {
          Navigator.pop(context);
          showLoading(context);
        } else if (state.logoutStatus == LogoutStatus.success) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            DefinedRoutes.loginScreenRoute,
            (route) => false,
          );
        } else if (state.logoutStatus == LogoutStatus.error) {
          displaySnackBar(
            contentType: ContentType.failure,
            title: state.logoutError.toString(),
          );
        }
      },
      child: Row(
        children: [
          const Icon(Icons.logout, size: 20),
          SizedBox(width: inherit.screenWidth * 0.01),
          Text(
            inherit.appLocalizations.logout,
            style: inherit.theme.textTheme.bodyMedium,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              _logout(context, profileCubit);
            },
            icon: Icon(Icons.logout, size: 30, color: AppColors.gray),
          ),
        ],
      ),
    );
  }

  void showLoading(context) {
    showDialog(
      context: context,
      builder:
          (context) => const AlertDialog(
            title: Center(child: CircularProgressIndicator()),
          ),
    );
  }

  void _logout(context, ProfileCubit profileCubit) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.logout),
            content: Text(AppLocalizations.of(context)!.logoutMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.cancelButton),
              ),
              TextButton(
                onPressed: () {
                  profileCubit.doIntent(LogoutIntent());
                },
                child: Text(AppLocalizations.of(context)!.confirmButton),
              ),
            ],
          ),
    );
  }
}
