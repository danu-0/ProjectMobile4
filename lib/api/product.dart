import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchProducts() async {
  final url = Uri.parse(
      'http://10.0.2.2:3000/product'); // Sesuaikan URL dengan endpoint Anda
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body);

    return jsonResponse.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load products');
  }
}
