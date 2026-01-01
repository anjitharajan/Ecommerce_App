import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../order/order_success_page.dart';

class CheckoutPage extends StatelessWidget {
  final double totalAmount;

   CheckoutPage({Key? key, required this.totalAmount}) : super(key: key);

  void placeOrder(BuildContext context) {

    //------- Hive Boxes -------\\
    final cartBox = Hive.box('cartBox');
    final orderBox = Hive.box('orderBox');

//------- Generate Unique Order ID -------\\
    final orderId =  Uuid().v4();

//------- Prepare Order Items -------\\
    final orderItems = cartBox.values.toList();

    orderBox.put(orderId, {
      'orderId': orderId,
      'date': DateTime.now().toString(),
      'total': totalAmount,
      'items': orderItems,
    });

//------- Clear Cart after placing order -------\\
    cartBox.clear();

//------- Navigate to Order Success Page -------\\
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>  OrderSuccessPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartBox = Hive.box('cartBox');

    return Scaffold(
      appBar: AppBar(
        title:  Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(

            //------- List of Cart Items -------\\
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

          //----- Total andPlace Order-------\\
          Container(
            padding:  EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Total Amount',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(

                      //------- Display Total Amount -------\\
                      "\$${totalAmount.toStringAsFixed(2)}",
                      style:
                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                 SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,

                  //------- Place Order Button -------\\
                  child: ElevatedButton(
                    onPressed: () => placeOrder(context),
                    child:  Text('Place Order'),
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
