import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {

  // ------- Fetch products from free API -------\\
  final String baseUrl = "https://fakestoreapi.com/products";

//------- Get products -------\\
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {

      //------- Handle error -------\\
      throw Exception("Failed to fetch products");
    }
  }
}
