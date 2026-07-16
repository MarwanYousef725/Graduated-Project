import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduated_project/features/profile/orders/data/order_model.dart';
import 'package:graduated_project/features/profile/orders/logic/orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  void loadOrders() async {
    emit(OrdersLoading());
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 600));

    final orders = [
      OrderModel(
        id: '#ORD-8829',
        date: 'Oct 12, 2023 at 04:30 PM',
        totalPrice: 425.00,
        itemsCount: 3,
        status: OrderStatus.delivered,
      ),
      OrderModel(
        id: '#ORD-8820',
        date: 'Oct 05, 2023 at 10:15 AM',
        totalPrice: 150.50,
        itemsCount: 1,
        status: OrderStatus.delivered,
      ),
      OrderModel(
        id: '#ORD-8715',
        date: 'Sep 28, 2023 at 08:45 AM',
        totalPrice: 890.00,
        itemsCount: 5,
        status: OrderStatus.shipped,
      ),
      OrderModel(
        id: '#ORD-8600',
        date: 'Sep 15, 2023 at 11:30 AM',
        totalPrice: 50.00,
        itemsCount: 1,
        status: OrderStatus.cancelled,
      ),
    ];

    emit(OrdersLoaded(orders));
  }
}
