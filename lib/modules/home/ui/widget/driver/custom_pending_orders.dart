import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPendingOrders extends StatefulWidget {
  final String title;
  final String state;
  final String icon;
  final String pickUpAddress;
  final String pickUpImage;
  final String pickUpName;
  final String userFirstName;
  final String userLastName;
  final String userImage;
  final String orderId;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const CustomPendingOrders({
    super.key,
    required this.title,
    required this.state,
    required this.icon,
    required this.pickUpAddress,
    required this.pickUpImage,
    required this.pickUpName,
    required this.userFirstName,
    required this.userLastName,
    required this.userImage,
    required this.orderId,
    required this.onAccept,
    required this.onReject,
  });

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.030),
                    Image.asset(
                      widget.icon,
                      width: MediaQuery.of(context).size.width * 0.050,
                      height: MediaQuery.of(context).size.height * 0.050,
                      color:
                          widget.state != 'canceled'
                              ? AppColors.green
                              : AppColors.red,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.005),
                    Text(
                      widget.state,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).textScaler.scale(16),
                        fontWeight: FontWeight.w500,
                        color:
                            widget.state != 'canceled'
                                ? AppColors.green
                                : AppColors.red,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.orderId,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaler.scale(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
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
                    widget.pickUpImage,
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
                    widget.userImage,
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
          ],
        ),
      ),
    );
  }
}
