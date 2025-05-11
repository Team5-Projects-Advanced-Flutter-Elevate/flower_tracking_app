import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';

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
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 20 * (screenWidth / 375),
          ),
        ),
      ),
      body:Column(
        children: [
          SizedBox(height: screenHeight*.008,),
          SizedBox( // Constrain the Row's height
            height: screenHeight*.0044, // Set this to your desired progress bar height
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
          SizedBox(height: screenHeight*.008,),
          Container(
            child: Column(

            ),
          )
        ],
      )
    );
  }
}
