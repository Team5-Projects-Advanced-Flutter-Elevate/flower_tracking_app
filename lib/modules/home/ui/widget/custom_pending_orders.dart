import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/pending_orders/pending_orders_cubit.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/pending_orders/pending_orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPendingOrders extends StatefulWidget {
  const CustomPendingOrders({
    super.key,
    required this.orderIndex,
    required this.title,
    required this.price,
    required this.pickUpAddress,
    required this.pickUpImage,
    required this.pickUpName,
    required this.userAddress,
    required this.userFirstName,
    required this.userLastName,
    required this.userImage,
    required this.onAccept,
    required this.onReject,
  });
  final int orderIndex;
  final String title;
  final String price;
  final String pickUpAddress;
  final dynamic pickUpImage;
  final String pickUpName;
  final String userAddress;
  final String userFirstName;
  final String userLastName;
  final String? userImage;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  State<CustomPendingOrders> createState() => _CustomPendingOrdersState();
}

class _CustomPendingOrdersState
    extends BaseStatefulWidgetState<CustomPendingOrders> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.008,
        vertical: screenHeight * 0.008,
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.032),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: theme.textTheme.titleSmall),
            SizedBox(height: screenHeight * 0.016),
            Text(
              appLocalizations.pickUpAddress,
              style: theme.textTheme.labelMedium!.copyWith(
                color: AppColors.gray,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenHeight * 0.016),
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    widget.pickUpImage!,
                    height: 44,
                    width: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (
                      BuildContext context,
                      Object exception,
                      StackTrace? stackTrace,
                    ) {
                      return ClipOval(
                        child: Image.asset(
                          AssetsPaths.unKnownAnyThing,
                          height: 44,
                          width: 44,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: screenWidth * 0.016),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.pickUpName,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.gray,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.008),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_city_outlined, size: 16),
                          Expanded(
                            child: Text(
                              widget.pickUpAddress,
                              style: theme.textTheme.bodyMedium!.copyWith(
                                fontSize: 13,
                                fontFamily: GoogleFonts.roboto().fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.016),
            Text(
              appLocalizations.userAddress,
              style: theme.textTheme.labelMedium!.copyWith(
                color: AppColors.gray,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenHeight * 0.016),
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    widget.userImage!,
                    height: 44,
                    width: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (
                      BuildContext context,
                      Object exception,
                      StackTrace? stackTrace,
                    ) {
                      return ClipOval(
                        child: Image.asset(
                          AssetsPaths.unKnownPerson,
                          height: 44,
                          width: 44,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: screenWidth * 0.016),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.userFirstName} ${widget.userLastName}',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.gray,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.008),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_city_outlined, size: 16),
                          Expanded(
                            child: Text(
                              widget.userAddress,
                              style: theme.textTheme.bodyMedium!.copyWith(
                                fontSize: 13,
                                fontFamily: GoogleFonts.roboto().fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.016),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${appLocalizations.eGP} ${widget.price}',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: widget.onReject,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.mainColor),
                      ),
                      child: Text(
                        appLocalizations.reject,
                        style: TextStyle(color: AppColors.mainColor),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.016),
                    BlocBuilder<OrdersCubit, OrdersState>(
                      buildWhen: (previous, current) {
                        if (current.pressedAcceptOfOrderIndex ==
                            widget.orderIndex) {
                          return true;
                        }
                        return false;
                      },
                      builder: (context, state) {
                        return FilledButton(
                          onPressed: widget.onAccept,
                          child:
                              state.addingOrderToFirestore == Status.loading
                                  ? const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                  : Text(appLocalizations.accept),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
