import 'package:flower_tracking_app/modules/update_status/domain/usecase/order_status_use_case.dart';
import 'package:flower_tracking_app/modules/update_status/ui/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/order_status.dart';

@injectable
class OrderStatusViewModel extends Cubit<UpdateStatusState> {
  UpdateOrderStatusUseCase updateOrderStatusUseCase;

  @factoryMethod
  OrderStatusViewModel(this.updateOrderStatusUseCase)
    : super(UpdateStatusInitial());

  void onIntent(ForgetIntent intent) {
    switch (intent) {
      case UpdateStateIntent():
        _updateStateHandling(intent.state, intent.orderId);
        break;
    }
  }

  _updateStateHandling(String state, String orderId) async {
    emit(UpdateStatusLoading());
    var result = await updateOrderStatusUseCase.call(state, orderId);
    switch (result) {
      case Success<OrderStatusUpdateEntity>():
        emit(UpdateStatusSuccess(result));

      case Error<OrderStatusUpdateEntity?>():
        emit(UpdateStatusError(result.toString()));
    }
  }
}

sealed class ForgetIntent {}

class UpdateStateIntent extends ForgetIntent {
  final String state;
  final String orderId;

  UpdateStateIntent(this.state, this.orderId);
}
