import 'product_model.dart';

class CartItem {
  final Product product;
  int quantity;

//------- cart item model -------\\
  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;

//------product mapping for cart item -------\\
  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}
