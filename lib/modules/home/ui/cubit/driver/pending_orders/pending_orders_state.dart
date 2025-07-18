import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/driver/orders_entity.dart';

enum LoadOrdersStatus { initial, loading, success, error, loadingMore }

class OrdersState extends Equatable {
  final LoadOrdersStatus status;
  final PendingOrdersEntity orders; // Non-nullable due to entity update
  final Object? error;
  final int currentPage;
  final int completedOrdersCount;
  final int notCompletedOrdersCount;

  const OrdersState({
    this.status = LoadOrdersStatus.initial,
    required this.orders, // Required and non-nullable
    this.error,
    this.currentPage = 1,
    this.completedOrdersCount = 0,
    this.notCompletedOrdersCount = 0,
  });

  OrdersState copyWith({
    LoadOrdersStatus? status,
    PendingOrdersEntity? orders,
    Object? error,
    int? currentPage,
    int? completedOrdersCount,
    int? notCompletedOrdersCount,
  }) => OrdersState(
    status: status ?? this.status,
    orders: orders ?? this.orders, // Use existing orders if null
    error: error ?? this.error,
    currentPage: currentPage ?? this.currentPage,
    completedOrdersCount: completedOrdersCount ?? this.completedOrdersCount,
    notCompletedOrdersCount:
        notCompletedOrdersCount ?? this.notCompletedOrdersCount,
  );

  @override
  List<Object?> get props => [
    status,
    orders,
    error,
    currentPage,
    completedOrdersCount,
    notCompletedOrdersCount,
  ];
}
