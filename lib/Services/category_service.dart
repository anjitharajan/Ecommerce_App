import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';

class CategoryService {
  // ------- Fetch categories from free API -------\\
  final String baseUrl = "https://fakestoreapi.com/products/categories";

//------- Get categories -------\\
  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((cat) => Category.fromJson(cat)).toList();
    } else {

      //------- Handle error -------\\
      throw Exception("Failed to fetch categories");
    }
  }
}
