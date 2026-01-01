import 'package:e_commerce_app/Screens/check_out/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartBox = Hive.box('cartBox');

  double get totalPrice {
    double total = 0;
    for (var item in cartBox.values) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  void increaseQty(dynamic key) {
    var item = cartBox.get(key);
    item['quantity'] += 1;
    cartBox.put(key, item);
    setState(() {});
  }

  void decreaseQty(dynamic key) {
    var item = cartBox.get(key);
    if (item['quantity'] > 1) {
      item['quantity'] -= 1;
      cartBox.put(key, item);
    } else {
      cartBox.delete(key);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: ValueListenableBuilder(
        valueListenable: cartBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final key = box.keyAt(index);
                    final item = box.get(key);

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: ListTile(
                        leading: Image.network(
                          item['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          item['title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle:
                            Text("\$${item['price']} x ${item['quantity']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => decreaseQty(key),
                            ),
                            Text(item['quantity'].toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => increaseQty(key),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 💲 Total & Checkout
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CheckoutPage(totalAmount: totalPrice),
                            ),
                          );
                        },
                        child: const Text('Proceed to Checkout'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
