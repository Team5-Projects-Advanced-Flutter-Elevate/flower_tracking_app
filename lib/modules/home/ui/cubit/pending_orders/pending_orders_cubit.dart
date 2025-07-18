import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/orders_entity.dart';
import 'package:flower_tracking_app/modules/home/domain/use_cases/get_pending_orders_use_case.dart';
import 'package:flower_tracking_app/modules/home/ui/cubit/pending_orders/pending_orders_state.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/order/order_entity_firestore.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/repositories_abstracts/firestore_repo_contract.dart';
import 'package:flower_tracking_app/shared_layers/storage/constants/storage_constants.dart';
import 'package:flower_tracking_app/shared_layers/storage/contracts/flutter_secure_storage_service_contract.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OrdersCubit extends Cubit<OrdersState> {
  final GetPendingOrdersUseCase useCase;
  final FirestoreRepoContract _firestoreRepoContract;
  final SecureStorageService _secureStorageService;
  bool _isLoading = false;

  OrdersCubit(
    this.useCase,
    this._firestoreRepoContract,
    this._secureStorageService,
  ) : super(const OrdersState());

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
    } else if (intent is OnAcceptButtonClick) {
      _onAcceptButtonClick(intent.driverId, intent.orderEntity);
    }
  }

  Future<void> _loadOrders({required int page, required bool isRefresh}) async {
    if (_isLoading || isClosed) {
      return;
    }
    _isLoading = true;
    if (!isClosed) {
      emit(OrdersState(loadOrdersStatus: Status.loading, currentPage: page));
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
                      ...result.data.orders ?? [],
                    ],
                  );
          emit(
            state.copyWith(
              loadOrdersStatus: Status.success,
              orders: newOrders,
              currentPage: page,
            ),
          );
        case Error<PendingOrdersEntity>():
          emit(
            state.copyWith(
              loadOrdersStatus: Status.error,
              error: result.error,
              currentPage: page,
            ),
          );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            loadOrdersStatus: Status.error,
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
      emit(state.copyWith(loadOrdersStatus: Status.loadingMore));
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
            orders: [
              ...(state.orders?.orders ?? []),
              ...result.data.orders ?? [],
            ],
          );
          emit(
            state.copyWith(
              loadOrdersStatus: Status.success,
              orders: newOrders,
              currentPage: nextPage,
            ),
          );
        case Error<PendingOrdersEntity>():
          emit(
            state.copyWith(
              loadOrdersStatus: Status.error,
              error: result.error,
              currentPage: state.currentPage,
            ),
          );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            loadOrdersStatus: Status.error,
            error: e,
            currentPage: state.currentPage,
          ),
        );
      }
    } finally {
      _isLoading = false;
    }
  }

  void _onAcceptButtonClick(
    String driverId,
    OrderEntityFirestore orderEntity,
  ) async {
    emit(state.copyWith(addingOrderToFirestore: Status.loading));
    var result = await _firestoreRepoContract.addOrder(
      driverId: driverId,
      orderEntity: orderEntity,
    );
    switch (result) {
      case Success<void>():
        _secureStorageService.setStringValue(
          StorageConstants.currentAcceptedOrderId,
          orderEntity.id ?? '',
        );
        emit(
          state.copyWith(
            addingOrderToFirestore: Status.success,
            addedOrderIdToFirestore: orderEntity.id ?? '',
          ),
        );
      case Error<void>():
        emit(
          state.copyWith(
            addingOrderToFirestore: Status.error,
            error: result.error,
          ),
        );
    }
  }

  removeOrder(String orderId) {
    final currentOrders = state.orders?.orders ?? [];
    final updatedOrders =
        currentOrders.where((order) => order.id != orderId).toList();

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
