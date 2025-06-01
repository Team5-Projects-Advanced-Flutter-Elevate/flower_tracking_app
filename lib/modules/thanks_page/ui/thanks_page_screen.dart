import 'package:flower_tracking_app/core/bases/base_statless_widget.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/routing/defined_routes.dart';
import 'package:flower_tracking_app/modules/thanks_page/ui/constants/thanks_page_constants.dart';
import 'package:flutter/material.dart';

class ThanksPageScreen extends BaseStatelessWidget {
  const ThanksPageScreen({super.key});

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: inherit.screenHeight * 0.06),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.vividGreen[10],
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(18),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.vividGreen[20],
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.vividGreen[30],
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.vividGreen,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        key: const Key(ThanksPageConstants.successIconKey),
                        Icons.check_sharp,
                        size: inherit.screenWidth * 0.13,
                        weight: 40,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: inherit.screenHeight * 0.03),
              RichText(
                textAlign: TextAlign.center,
                key: const Key(ThanksPageConstants.successMessageKey),
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${inherit.appLocalizations.thankYou}\n',
                      style: inherit.theme.textTheme.titleLarge!.copyWith(
                        color: AppColors.green,
                        height: 1.4,
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: inherit.appLocalizations.orderDeliveredSuccessfully,
                      style: inherit.theme.textTheme.titleLarge!.copyWith(
                        height: 1.5,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: inherit.screenHeight * 0.03),
              FilledButton(
                key: const Key(ThanksPageConstants.doneButtonKey),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    DefinedRoutes.layoutScreen,
                    (route) => false,
                  );
                },
                child: Text(inherit.appLocalizations.done),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
