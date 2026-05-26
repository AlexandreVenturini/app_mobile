import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/categoria.dart';

class CategoriaService {
  Future<List<Categoria>> getCategorias() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/categorias/'),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Categoria.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar categorias');
    }
  }
}
