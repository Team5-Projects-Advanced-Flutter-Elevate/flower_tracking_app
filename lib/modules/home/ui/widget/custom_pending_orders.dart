import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPendingOrders extends StatefulWidget {
  const CustomPendingOrders({
    super.key,
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

  final String title;
  final String price;
  final String pickUpAddress;
  final String pickUpImage;
  final String pickUpName;
  final String userAddress;
  final String userFirstName;
  final String userLastName;
  final String userImage;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  State<CustomPendingOrders> createState() => _CustomPendingOrdersState();
}

class _CustomPendingOrdersState extends BaseStatefulWidgetState<CustomPendingOrders> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.032),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: AppThemes.lightTheme.textTheme.titleSmall,
            ),
            SizedBox(height: screenHeight * 0.016),
            Text(
              'Pickup address',
              style: AppThemes.lightTheme.textTheme.labelMedium!.copyWith(
                color: AppColors.gray,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenHeight * 0.016),
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                    widget.pickUpImage.isNotEmpty
                        ? widget.pickUpImage
                        : 'https://via.placeholder.com/150',
                  ),
                ),
                SizedBox(width: screenWidth * 0.016),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pickUpName,
                      style: AppThemes.lightTheme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.gray,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    Row(
                      children: [
                        const Icon(Icons.location_city_outlined, size: 16),
                        Text(
                          widget.pickUpAddress,
                          style: AppThemes.lightTheme.textTheme.bodyMedium!.copyWith(
                            fontSize: 13,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.016),
            Text(
              'User address',
              style: AppThemes.lightTheme.textTheme.labelMedium!.copyWith(
                color: AppColors.gray,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenHeight * 0.016),
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                    widget.userImage.isNotEmpty
                        ? widget.userImage
                        : 'https://via.placeholder.com/150',
                  ),
                ),
                SizedBox(width: screenWidth * 0.016),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.userFirstName} ${widget.userLastName}',
                      style: AppThemes.lightTheme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.gray,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    Row(
                      children: [
                        const Icon(Icons.location_city_outlined, size: 16),
                        Text(
                          widget.userAddress,
                          style: AppThemes.lightTheme.textTheme.bodyMedium!.copyWith(
                            fontSize: 13,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.016),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'EGP ${widget.price}',
                  style: AppThemes.lightTheme.textTheme.bodyMedium!.copyWith(
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
                        style: TextStyle(color: Color(0xFFD21E6A)),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.016),
                    FilledButton(
                      onPressed: widget.onAccept,
                      child: Text(appLocalizations.accept),
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