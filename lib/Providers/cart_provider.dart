import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {

  //------- Access Hive cart box -------\\
  final Box cartBox = Hive.box('cartBox');

//------- Get cart items -------\\
  List<CartItem> get cartItems =>
      cartBox.values.map((e) => CartItem.fromJson(Map<String, dynamic>.from(e))).toList();

//------- Add to cart -------\\
  void addToCart(Product product) {
    if (cartBox.containsKey(product.id)) {

      //------- Update quantity if item exists -------\\
      CartItem existing = CartItem.fromJson(Map<String, dynamic>.from(cartBox.get(product.id)));
      existing.quantity += 1;

      //------- Save updated item -------\\
      cartBox.put(product.id, existing.toJson());
    } else {

      //------- Add new item to cart -------\\
      cartBox.put(product.id, CartItem(product: product).toJson());
    }

    //------- Notify listeners about the change -------\\
    notifyListeners();
  }

//------- Remove from cart -------\\
  void removeFromCart(int productId) {
    cartBox.delete(productId);
    notifyListeners();
  }
//------- Clear cart -------\\
  void clearCart() {
    cartBox.clear();
    notifyListeners();
  }

//------- Get total price -------\\
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);
}
