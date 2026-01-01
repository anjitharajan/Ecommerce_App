import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //------- Hive Order Box -------\\
    final orderBox = Hive.box('orderBox');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ValueListenableBuilder(

        //------- Listen to Order Box Changes -------\\
        valueListenable: orderBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No orders found'),
            );
          }

//------- List of Orders -------\\
          final orders = box.values.toList().reversed.toList(); 

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return Card(

                //------- Order Summary Tile -------\\
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ExpansionTile(
                  title: Text(
                    "Order ID: ${order['orderId']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "Date: ${DateTime.parse(order['date']).toLocal().toString().split('.')[0]}\nTotal: \$${order['total'].toStringAsFixed(2)}"),
                  children: [
                    const Divider(),
                    ...List.generate(order['items'].length, (i) {
                      final item = order['items'][i];
                      return ListTile(
                        leading: Image.network(
                          item['image'],
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          item['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle:
                            Text("\$${item['price']} x ${item['quantity']}"),
                      );
                    }),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
