import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProductDetailPage extends StatelessWidget {
  final Map product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  void addToCart(BuildContext context) {
    //------- Hive Cart Box -------\\
    final cartBox = Hive.box('cartBox');

    //-----Checking for product already exists in cart------\\
    if (cartBox.containsKey(product['id'])) {
      var item = cartBox.get(product['id']);
      item['quantity'] += 1;
      cartBox.put(product['id'], item);
    } else {
      //------- Add New Product to Cart -------\\
      cartBox.put(product['id'], {
        'id': product['id'],
        'title': product['title'],
        'price': product['price'],
        'image': product['image'],
        'quantity': 1,
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //------ Product Image-------\\
            Center(
              child: Image.network(
                product['image'],
                height: 200,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),

            //----- Title-------\\
            Text(
              product['title'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            //----- Price-----\\
            Text(
              "\$${product['price']}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            //-----Rating -----\\
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 20),
                const SizedBox(width: 5),
                Text(
                  product['rating'] != null
                      ? product['rating']['rate'].toString()
                      : '4.5',
                ),
              ],
            ),

            const SizedBox(height: 20),

            //----- Description-------\\
            const Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product['description'],
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 30),

            //----- Add to Cart Button-------\\
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => addToCart(context),
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
