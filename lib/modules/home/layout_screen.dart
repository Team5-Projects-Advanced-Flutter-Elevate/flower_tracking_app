import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flower_tracking_app/modules/home/ui/constants/home_constants.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/home/ui/home_screen.dart';
import 'package:flower_tracking_app/modules/home/ui/driver/orders_screen.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/profile_screen.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/viewModel/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../edit_profile/ui/screens/edit_profile_screen.dart';

import '../update_status/ui/screen/order_state.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  static const String routeName = 'Layout Screen';

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends BaseStatefulWidgetState<LayoutScreen> {
  late PageController controller;
  int currentScreen = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const OrdersScreen(),
    BlocProvider(
      create: (context) => getIt<ProfileCubit>(),
      child: const OrderState(),
    ),
    const EditProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key(HomeConstants.layoutScreenKey),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.mainColor, // Selected label color
              );
            }
            return TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.gray, // Unselected label color
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: currentScreen,
          backgroundColor: AppColors.white,
          onDestinationSelected: (value) {
            setState(() {
              currentScreen = value;
            });
            controller.jumpToPage(currentScreen);
          },
          destinations: [
            NavigationDestination(
              icon: ImageIcon(
                color:
                    currentScreen == 0 ? AppColors.mainColor : AppColors.gray,
                const AssetImage(AssetsPaths.homeIcon),
              ),
              label: appLocalizations.home,
            ),
            NavigationDestination(
              icon: ImageIcon(
                color:
                    currentScreen == 1 ? AppColors.mainColor : AppColors.gray,
                const AssetImage(AssetsPaths.ordersIcon),
              ),
              label: appLocalizations.orders,
            ),
            NavigationDestination(
              icon: ImageIcon(
                color:
                    currentScreen == 2 ? AppColors.mainColor : AppColors.gray,
                const AssetImage(AssetsPaths.profileIcon),
              ),
              label: appLocalizations.profile,
            ),
          ],
        ),
      ),
    );
  }
}
