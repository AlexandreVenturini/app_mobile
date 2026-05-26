import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/carrinho.dart';

class CarrinhoService {
  // GET carrinhos
  Future<List<Carrinho>> getCarrinhos() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/carrinhos/'),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Carrinho.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar carrinhos');
    }
  }

  // POST criar carrinho
  Future<Carrinho> createCarrinho(Carrinho carrinho) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/carrinhos/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(carrinho.toJson()),
    );

    if (response.statusCode == 201) {
      return Carrinho.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao criar carrinho');
    }
  }
}
