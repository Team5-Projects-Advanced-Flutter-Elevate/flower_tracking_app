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

  OrdersCubit(this.useCase) : super(const OrdersState()) {
    print('Creating OrdersCubit: $this');
  }

  Future<void> doIntent(OrdersIntent intent) async {
    if (_isLoading || isClosed) {
      print('Skipping intent: already loading or cubit closed');
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
      print('Skipping _loadOrders: already loading or cubit closed');
      return;
    }
    _isLoading = true;
    print('Emitting loading state for page $page, isRefresh: $isRefresh');
    if (!isClosed) {
      emit(state.copyWith(status: LoadOrdersStatus.loading, currentPage: page));
    }
    try {
      var result = await useCase.execute(page: page);
      if (isClosed) {
        print('Cubit closed before emitting result');
        return;
      }
      switch (result) {
        case Success<PendingOrdersEntity>():
          final newOrders = isRefresh || page == 1
              ? result.data
              : PendingOrdersEntity(
                  message: result.data.message,
                  metadata: result.data.metadata,
                  orders: [...(state.orders?.orders ?? []), ...result.data.orders],
                );
          print('Emitting success state: ${newOrders.orders.length} orders, page $page');
          emit(state.copyWith(
            status: LoadOrdersStatus.success,
            orders: newOrders,
            currentPage: page,
          ));
        case Error<PendingOrdersEntity>():
          print('Emitting error state: ${result.error}');
          emit(state.copyWith(
            status: LoadOrdersStatus.error,
            error: result.error,
            currentPage: page,
          ));
      }
    } catch (e) {
      if (!isClosed) {
        print('Error in _loadOrders: $e');
        emit(state.copyWith(
          status: LoadOrdersStatus.error,
          error: e,
          currentPage: page,
        ));
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _loadMoreOrders() async {
    if (_isLoading || isClosed) {
      print('Skipping _loadMoreOrders: already loading or cubit closed');
      return;
    }
    final metadata = state.orders?.metadata;
    final nextPage = state.currentPage + 1;
    if (metadata != null && nextPage > metadata.totalPages) {
      print('No more pages to load: currentPage ${state.currentPage}, totalPages ${metadata.totalPages}');
      return;
    }
    _isLoading = true;
    print('Emitting loadingMore state for page $nextPage');
    if (!isClosed) {
      emit(state.copyWith(status: LoadOrdersStatus.loadingMore));
    }
    try {
      var result = await useCase.execute(page: nextPage);
      if (isClosed) {
        print('Cubit closed before emitting result');
        return;
      }
      switch (result) {
        case Success<PendingOrdersEntity>():
          final newOrders = PendingOrdersEntity(
            message: result.data.message,
            metadata: result.data.metadata,
            orders: [...(state.orders?.orders ?? []), ...result.data.orders],
          );
          print('Emitting success state: ${newOrders.orders.length} orders, page $nextPage');
          emit(state.copyWith(
            status: LoadOrdersStatus.success,
            orders: newOrders,
            currentPage: nextPage,
          ));
        case Error<PendingOrdersEntity>():
          print('Emitting error state: ${result.error}');
          emit(state.copyWith(
            status: LoadOrdersStatus.error,
            error: result.error,
            currentPage: state.currentPage,
          ));
      }
    } catch (e) {
      if (!isClosed) {
        print('Error in _loadMoreOrders: $e');
        emit(state.copyWith(
          status: LoadOrdersStatus.error,
          error: e,
          currentPage: state.currentPage,
        ));
      }
    } finally {
      _isLoading = false;
    }
  }

  @override
  Future<void> close() {
    print('Closing OrdersCubit');
    return super.close();
  }
}