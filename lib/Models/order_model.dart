import 'cart_item_model.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double totalPrice;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.dateTime,
  });

//------- order model -------\\

  Map<String, dynamic> toJson() => {
        'id': id,
        'items': items.map((e) => e.toJson()).toList(),
        'totalPrice': totalPrice,
        'dateTime': dateTime.toIso8601String(),
      };

//------ order mapping -------\\
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
