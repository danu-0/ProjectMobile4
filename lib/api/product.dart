import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchProducts() async {
  final url = Uri.parse('https://nest-js-nine.vercel.app/product');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body);

    return jsonResponse.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load products');
  }
}
