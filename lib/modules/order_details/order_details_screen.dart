import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/bases/base_stateful_widget_state.dart';
import '../../core/colors/app_colors.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState
    extends BaseStatefulWidgetState<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text(
          'Order Details',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 20 * (screenWidth / 375),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * .008),
                SizedBox(
                  // Constrain the Row's height
                  height: screenHeight * .0044,
                  // Set this to your desired progress bar height
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: SizedBox(
                                width: screenWidth * 0.16,
                                child: LinearProgressIndicator(
                                  color: AppColors.green,
                                  value: 1,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * .008),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightPink,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: screenWidth,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),

                  child: Column(
                    spacing: screenHeight * .01,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status: Accepted',
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Order ID: #123656',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Wed, 03 Sep 2024, 11:00 AM ',
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Pickup address',
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
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
                          backgroundImage: AssetImage(
                            'assets/images/Flowery logo.png',
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Flowery store',
                            style: theme.textTheme.bodySmall!.copyWith(
                              fontSize: 13,
                              color: AppColors.gray,
                            ),
                          ),
                          Row(
                            children: [
                              ImageIcon(
                                AssetImage('assets/icons/location_icon.png'),
                              ),
                              Text(
                                '20th st, Sheikh Zayed, Giza ',
                                style: GoogleFonts.roboto(
                                  textStyle: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.15),
                      ImageIcon(
                        AssetImage('assets/icons/call_icon.png'),
                        color: AppColors.mainColor,
                      ),

                      SvgPicture.asset('assets/icons/whatsapp_icon.svg'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'User address',
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
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
                          backgroundImage: AssetImage(
                            'assets/images/Flowery logo.png',
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Flowery store',
                            style: theme.textTheme.bodySmall!.copyWith(
                              fontSize: 13,
                              color: AppColors.gray,
                            ),
                          ),
                          Row(
                            children: [
                              ImageIcon(
                                AssetImage('assets/icons/location_icon.png'),
                              ),
                              Text(
                                '20th st, Sheikh Zayed, Giza ',
                                style: GoogleFonts.roboto(
                                  textStyle: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.15),
                      ImageIcon(
                        AssetImage('assets/icons/call_icon.png'),
                        color: AppColors.mainColor,
                      ),

                      SvgPicture.asset('assets/icons/whatsapp_icon.svg'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Order details',
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
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
                          backgroundImage: AssetImage(
                            'assets/images/Flowery logo.png',
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Red roses,15 Pink Rose Bouquet',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,

                                style: theme.textTheme.bodySmall!.copyWith(
                                  fontSize: 13,
                                  color: AppColors.gray,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.16),
                              Text(
                                'X1  ',
                                style: GoogleFonts.roboto(
                                  textStyle: theme.textTheme.labelSmall!
                                      .copyWith(
                                    fontSize: 13,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'EGP 600  ',
                            style: GoogleFonts.roboto(
                              textStyle: theme.textTheme.labelSmall!.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'EGP 600  ',
                        style: GoogleFonts.roboto(
                          textStyle: theme.textTheme.labelLarge!.copyWith(
                            color: AppColors.gray,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment method',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Cash on delivery',
                        style: GoogleFonts.roboto(
                          textStyle: theme.textTheme.labelLarge!.copyWith(
                            color: AppColors.gray,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
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
            height: screenHeight * .09,
            width: screenWidth,
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(fixedSize: Size(250, 30),

              ),
              onPressed: () {},
              child: Text(
                'Arrived at Pickup point',
                style: theme.textTheme.titleMedium!.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
