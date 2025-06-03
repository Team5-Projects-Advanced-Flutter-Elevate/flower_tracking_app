import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injectable_initializer.dart';
import '../cubit/state.dart';
import '../cubit/viewModel.dart';

class OrderState extends StatefulWidget {
  const OrderState({super.key});

  @override
  State<OrderState> createState() => _OrderStateState();
}

class _OrderStateState extends State<OrderState> {
  OrderStatusViewModel callUpdateState = getIt.get<OrderStatusViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => callUpdateState,
      child: BlocListener<OrderStatusViewModel, UpdateStatusState>(
        listener: (context, state) {
          if (state is UpdateStatusLoading) {
            print('Loading...');
          } else if (state is UpdateStatusSuccess) {
            print('Status Updated Successfully: ${state.data}');
          } else if (state is UpdateStatusError) {
            print('Failed to update: ${state.message}');
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                callUpdateState.onIntent(UpdateStateIntent('pending','678a9bb63745562ff48ce07b'));
              },

              child: const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'complete',
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
