import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../core/bases/base_stateful_widget_state.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_paths/assets_paths.dart';
import '../../../core/di/injectable_initializer.dart';
import '../../../core/widgets/loading_state_widget.dart';
import '../../whatsapp_call/ui/cubit/launcher_view_model.dart';
import '../../whatsapp_call/ui/cubit/state.dart';

class AddressItem extends StatefulWidget {
  const AddressItem({super.key});

  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends BaseStatefulWidgetState<AddressItem> {
  LauncherViewModel launcherViewModel =
  getIt.get<LauncherViewModel>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => launcherViewModel,
      child: BlocConsumer<LauncherViewModel, LauncherState>(
        builder:
            (context, state) =>Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white[70]!,
                    blurRadius: 1.5,
                    spreadRadius: 1.5,
                    offset: const Offset(1, 1),
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                //border: Border.all(color: AppColors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              width: screenWidth,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.only(end: 8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(AssetsPaths.flowerLogo),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalizations.floweryStore,
                          style: theme.textTheme.bodySmall!.copyWith(
                            fontSize: 13,
                            color: AppColors.gray,
                          ),
                        ),
                        Row(
                          children: [
                            const ImageIcon(AssetImage(AssetsPaths.locationIcon)),
                            Text(
                              '20th st, Sheikh Zayed, Giza ',
                              style: GoogleFonts.roboto(
                                textStyle: theme.textTheme.bodySmall!.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(width: inherit.screenWidth * 0.15),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            launcherViewModel.onIntent(CallIntent('01006523275'));
                          },
                          child: ImageIcon(
                            const AssetImage(AssetsPaths.callIcon),
                            color: AppColors.mainColor,
                          ),
                        ),

                        GestureDetector(
                            onTap: () {
                              launcherViewModel.onIntent(WhatsAppIntent('+201006523275'));
                            },
                            child: SvgPicture.asset(AssetsPaths.whatsappIcon)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        listener: (context, state) {
          if (state is LauncherSuccess) {
            displaySnackBar(
              contentType: ContentType.success,
              title: 'Success',
              message: 'opening......',
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

