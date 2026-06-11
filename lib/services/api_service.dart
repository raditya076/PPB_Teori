import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data: ${response.statusCode}');
    }
  }
}