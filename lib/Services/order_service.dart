import 'package:hive/hive.dart';
import '../models/order_model.dart';

class OrderService {

  //------- Access Hive order box -------\\
  final Box orderBox = Hive.box('orderBox');

//------- Save order -------\\
  void saveOrder(Order order) {
    orderBox.put(order.id, order.toJson());
  }

//------- Get orders -------\\
  List<Order> getOrders() {
    return orderBox.values.map((json) => Order.fromJson(json)).toList();
  }

//------- Clear orders -------\\
  void clearOrders() {
    orderBox.clear();
  }
}
