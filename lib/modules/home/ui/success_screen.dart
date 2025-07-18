import 'package:flower_tracking_app/core/bases/base_inherited_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/bases/base_statless_widget.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_paths/assets_paths.dart';

class SuccessScreen extends BaseStatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    final screenH = inherit.screenHeight;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Lottie.asset(AssetsPaths.successJsonFile, width: 150)],
            ),
            SizedBox(height: screenH * 0.10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  inherit.appLocalizations.thankYou,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: AppColors.green),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    inherit.appLocalizations.successScreenDescription,
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenH * 0.10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(inherit.appLocalizations.done),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
