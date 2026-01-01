import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

//------- order provider -------\\
class OrderProvider extends ChangeNotifier {
  final OrderService _orderService = OrderService();

//------- Get orders -------\\
  List<Order> get orders => _orderService.getOrders();

//------- Add order -------\\
  void addOrder(Order order) {
    
    //------ Save order -------\\
    _orderService.saveOrder(order);

    //------- Notify listeners -------\\
    notifyListeners();
  }
}
