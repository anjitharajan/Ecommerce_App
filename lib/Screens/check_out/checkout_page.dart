import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../order/order_success_page.dart';

class CheckoutPage extends StatelessWidget {
  final double totalAmount;

  const CheckoutPage({Key? key, required this.totalAmount}) : super(key: key);

  void placeOrder(BuildContext context) {
    final cartBox = Hive.box('cartBox');
    final orderBox = Hive.box('orderBox');

    final orderId = const Uuid().v4();

    final orderItems = cartBox.values.toList();

    orderBox.put(orderId, {
      'orderId': orderId,
      'date': DateTime.now().toString(),
      'total': totalAmount,
      'items': orderItems,
    });

    cartBox.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const OrderSuccessPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartBox = Hive.box('cartBox');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartBox.length,
              itemBuilder: (context, index) {
                final item = cartBox.getAt(index);

                return ListTile(
                  leading: Image.network(
                    item['image'],
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    item['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                      "\$${item['price']} x ${item['quantity']}"),
                );
              },
            ),
          ),

          // 💲 Total + Place Order
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${totalAmount.toStringAsFixed(2)}",
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => placeOrder(context),
                    child: const Text('Place Order'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
