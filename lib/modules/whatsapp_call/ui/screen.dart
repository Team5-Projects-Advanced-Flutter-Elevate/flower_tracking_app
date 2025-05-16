import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flower_tracking_app/modules/whatsapp_call/ui/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bases/base_stateful_widget_state.dart';
import '../../../core/di/injectable_initializer.dart';
import '../../../core/widgets/loading_state_widget.dart';
import 'cubit/launcher_view_model.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends BaseStatefulWidgetState<LauncherScreen> {
  LauncherViewModel launcherViewModel =
  getIt.get<LauncherViewModel>();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => launcherViewModel,
      child: BlocConsumer<LauncherViewModel, LauncherState>(
        builder:
            (context, state) => Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: screenWidth * 0.05,
                  ),
                ),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        launcherViewModel.onIntent(CallIntent('01006523275'));
                      },
                      child: const Icon(Icons.call)),
                  GestureDetector(
                      onTap: () {
                        launcherViewModel.onIntent(WhatsAppIntent('+201006523275'));
                      },
                      child: const Icon(Icons.chat)),

                ],
              )
            ],
          )
        ),
        listener: (context, state) {
          if (state is LauncherSuccess) {
            displaySnackBar(
              contentType: ContentType.success,
              title: 'Success',
              message: 'Code is valid',
            );

          } else if (state is LauncherError) {

            displaySnackBar(
              contentType: ContentType.failure,
              title: 'fail',
              message: state.message,
            );
          } else if (state is LauncherLoading) {
            const LoadingStateWidget();
          }
        },
      ),
    );
  }
}
