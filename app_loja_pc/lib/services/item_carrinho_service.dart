import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/item_carrinho.dart';

class ItemCarrinhoService {
  Future<List<ItemCarrinho>> getItens() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/itens-carrinho/'),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => ItemCarrinho.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar itens');
    }
  }

  Future<void> addItem(ItemCarrinho item) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/itens-carrinho/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar item');
    }
  }

  Future<void> updateItem(ItemCarrinho item) async {
    final response = await http.put(
      Uri.parse('${ApiConfig.baseUrl}/itens-carrinho/${item.idItemCarrinho}/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar item');
    }
  }

  Future<void> deleteItem(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/itens-carrinho/$id/'),
    );

    if (response.statusCode != 204) {
      throw Exception('Erro ao remover item');
    }
  }
}
