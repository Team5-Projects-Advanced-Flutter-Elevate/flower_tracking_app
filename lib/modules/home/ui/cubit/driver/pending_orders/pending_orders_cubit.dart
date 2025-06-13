import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/driver/orders_entity.dart';
import 'package:flower_tracking_app/modules/home/domain/use_cases/driver/get_pending_orders_use_case.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/driver/pending_orders/pending_orders_state.dart';
import 'package:injectable/injectable.dart';

sealed class OrdersIntent {}

class LoadOrdersIntent extends OrdersIntent {}

class LoadMoreOrdersIntent extends OrdersIntent {}

class RefreshOrdersIntent extends OrdersIntent {}

class RejectOrderIntent extends OrdersIntent {
  final String orderId;

  RejectOrderIntent(this.orderId);
}

@lazySingleton
class OrdersCubit extends Cubit<OrdersState> {
  final GetPendingOrdersUseCase useCase;
  bool _isLoading = false;

  OrdersCubit(this.useCase)
    : super(
        OrdersState(
          orders: PendingOrdersEntity(
            message: '',
            metadata: Metadata(
              currentPage: 1,
              totalPages: 1,
              totalItems: 0,
              limit: 10,
            ),
            orders: [],
          ),
        ),
      );

  Future<void> doIntent(OrdersIntent intent) async {
    if (_isLoading || isClosed) return;
    if (intent is LoadOrdersIntent) {
      await _loadOrders(page: 1, isRefresh: false);
    } else if (intent is LoadMoreOrdersIntent) {
      await _loadMoreOrders();
    } else if (intent is RefreshOrdersIntent) {
      await _loadOrders(page: 1, isRefresh: true);
    } else if (intent is RejectOrderIntent) {
      removeOrder(intent.orderId);
    }
  }

  Future<void> _loadOrders({required int page, required bool isRefresh}) async {
    if (_isLoading || isClosed) return;
    _isLoading = true;
    emit(state.copyWith(status: LoadOrdersStatus.loading, currentPage: page));
    try {
      final result = await useCase.execute(page: page);
      if (isClosed) return;
      if (result case Success<PendingOrdersEntity>(data: final newOrders)) {
        final completedCount =
            newOrders.orders.where((order) => order.state != 'canceled').length;
        final notCompletedCount =
            newOrders.orders.where((order) => order.state == 'canceled').length;
        emit(
          state.copyWith(
            status: LoadOrdersStatus.success,
            orders: newOrders,
            currentPage: page,
            completedOrdersCount: completedCount,
            notCompletedOrdersCount: notCompletedCount,
          ),
        );
      } else if (result case Error<PendingOrdersEntity>(error: final error)) {
        emit(
          state.copyWith(
            status: LoadOrdersStatus.error,
            error: error,
            currentPage: page,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            status: LoadOrdersStatus.error,
            error: e,
            currentPage: page,
          ),
        );
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _loadMoreOrders() async {
    if (_isLoading || isClosed) return;
    final metadata = state.orders.metadata;
    final nextPage = state.currentPage + 1;
    if (nextPage > metadata.totalPages) return;
    _isLoading = true;
    emit(state.copyWith(status: LoadOrdersStatus.loadingMore));
    try {
      final result = await useCase.execute(page: nextPage);
      if (isClosed) return;
      if (result case Success<PendingOrdersEntity>(data: final newOrders)) {
        final updatedOrders = PendingOrdersEntity(
          message: newOrders.message,
          metadata: newOrders.metadata,
          orders: [...state.orders.orders, ...newOrders.orders],
        );
        final completedCount =
            updatedOrders.orders
                .where((order) => order.state != 'canceled')
                .length;
        final notCompletedCount =
            updatedOrders.orders
                .where((order) => order.state == 'canceled')
                .length;
        emit(
          state.copyWith(
            status: LoadOrdersStatus.success,
            orders: updatedOrders,
            currentPage: nextPage,
            completedOrdersCount: completedCount,
            notCompletedOrdersCount: notCompletedCount,
          ),
        );
      } else if (result case Error<PendingOrdersEntity>(error: final error)) {
        emit(
          state.copyWith(
            status: LoadOrdersStatus.error,
            error: error,
            currentPage: state.currentPage,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            status: LoadOrdersStatus.error,
            error: e,
            currentPage: state.currentPage,
          ),
        );
      }
    } finally {
      _isLoading = false;
    }
  }

  void removeOrder(String orderId) {
    final updatedOrders =
        state.orders.orders.where((order) => order.id != orderId).toList();
    final updatedEntity = PendingOrdersEntity(
      message: state.orders.message,
      metadata: state.orders.metadata.copyWith(
        totalItems: updatedOrders.length,
      ),
      orders: updatedOrders,
    );
    final completedCount =
        updatedOrders.where((order) => order.state != 'canceled').length;
    final notCompletedCount =
        updatedOrders.where((order) => order.state == 'canceled').length;
    emit(
      state.copyWith(
        orders: updatedEntity,
        completedOrdersCount: completedCount,
        notCompletedOrdersCount: notCompletedCount,
      ),
    );
  }
}
