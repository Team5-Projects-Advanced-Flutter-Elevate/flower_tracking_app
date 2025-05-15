import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/orders_entity.dart';
import 'package:flower_tracking_app/modules/home/domain/use_cases/get_pending_orders_use_case.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/pending_orders/pending_orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OrdersCubit extends Cubit<OrdersState> {
  final GetPendingOrdersUseCase useCase;
  bool _isLoading = false;

  OrdersCubit(this.useCase) : super(const OrdersState());

  Future<void> doIntent(OrdersIntent intent) async {
    if (_isLoading || isClosed) {
      return;
    }
    if (intent is LoadOrdersIntent) {
      await _loadOrders(page: 1, isRefresh: false);
    } else if (intent is LoadMoreOrdersIntent) {
      await _loadMoreOrders();
    } else if (intent is RefreshOrdersIntent) {
      await _loadOrders(page: 1, isRefresh: true);
    } 
  }

  Future<void> _loadOrders({required int page, required bool isRefresh}) async {
    if (_isLoading || isClosed) {
      return;
    }
    _isLoading = true;
    if (!isClosed) {
      emit(state.copyWith(status: LoadOrdersStatus.loading, currentPage: page));
    }
    try {
      var result = await useCase.execute(page: page);
      if (isClosed) {
        return;
      }
      switch (result) {
        case Success<PendingOrdersEntity>():
          final newOrders =
              isRefresh || page == 1
                  ? result.data
                  : PendingOrdersEntity(
                    message: result.data.message,
                    metadata: result.data.metadata,
                    orders: [
                      ...(state.orders?.orders ?? []),
                      ...result.data.orders,
                    ],
                  );
          emit(
            state.copyWith(
              status: LoadOrdersStatus.success,
              orders: newOrders,
              currentPage: page,
            ),
          );
        case Error<PendingOrdersEntity>():
          emit(
            state.copyWith(
              status: LoadOrdersStatus.error,
              error: result.error,
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
    if (_isLoading || isClosed) {
      return;
    }
    final metadata = state.orders?.metadata;
    final nextPage = state.currentPage + 1;
    if (metadata != null && nextPage > metadata.totalPages) {
      return;
    }
    _isLoading = true;
    if (!isClosed) {
      emit(state.copyWith(status: LoadOrdersStatus.loadingMore));
    }
    try {
      var result = await useCase.execute(page: nextPage);
      if (isClosed) {
        return;
      }
      switch (result) {
        case Success<PendingOrdersEntity>():
          final newOrders = PendingOrdersEntity(
            message: result.data.message,
            metadata: result.data.metadata,
            orders: [...(state.orders?.orders ?? []), ...result.data.orders],
          );
          emit(
            state.copyWith(
              status: LoadOrdersStatus.success,
              orders: newOrders,
              currentPage: nextPage,
            ),
          );
        case Error<PendingOrdersEntity>():
          emit(
            state.copyWith(
              status: LoadOrdersStatus.error,
              error: result.error,
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
  removeOrder(String orderId) {
    final currentOrders = state.orders?.orders ?? [];
    final updatedOrders = currentOrders.where((order) => order.id != orderId).toList();

    emit(
      state.copyWith(
        orders: state.orders?.copyWith(
          orders: updatedOrders,
          metadata: state.orders!.metadata?.copyWith(
            totalItems: updatedOrders.length,
          ),
        ),
      ),
    );
  }
}
