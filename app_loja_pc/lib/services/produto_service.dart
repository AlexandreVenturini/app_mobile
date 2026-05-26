import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/produto.dart';

class ProdutoService {
  // 🔍 GET - listar produtos
  Future<List<Produto>> getProdutos() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/produtos/'),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Produto.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar produtos');
    }
  }

  // ➕ POST - criar produto
  Future<void> createProduto(Produto produto) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/produtos/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produto.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao criar produto');
    }
  }

  // ✏️ PUT - atualizar produto
  Future<void> updateProduto(Produto produto) async {
    final response = await http.put(
      Uri.parse('${ApiConfig.baseUrl}/produtos/${produto.idProduto}/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar produto');
    }
  }

  // 🗑️ DELETE - deletar produto
  Future<void> deleteProduto(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/produtos/$id/'),
    );

    if (response.statusCode != 204) {
      throw Exception('Erro ao deletar produto');
    }
  }
}
