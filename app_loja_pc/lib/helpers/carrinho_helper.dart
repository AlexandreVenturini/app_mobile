import 'package:flutter/material.dart';
import '../models/carrinho.dart';
import '../models/item_carrinho.dart';
import '../models/produto.dart';
import '../services/carrinho_service.dart';
import '../services/item_carrinho_service.dart';

class CarrinhoHelper {
  static Future<void> adicionarProdutoAoCarrinho({
    required BuildContext context,
    required Produto produto,
    int quantidade = 1,
  }) async {
    final carrinhoService = CarrinhoService();
    final itemService = ItemCarrinhoService();

    final carrinhos = await carrinhoService.getCarrinhos();

    Carrinho carrinhoAtual;

    if (carrinhos.isNotEmpty) {
      carrinhoAtual = carrinhos.first;
    } else {
      carrinhoAtual = await carrinhoService.createCarrinho(
        Carrinho(usuario: 1, valor: 0, status: 'Aberto'),
      );
    }

    final itens = await itemService.getItens();

    ItemCarrinho? itemExistente;

    for (var item in itens) {
      if (item.carrinho == carrinhoAtual.idCarrinho &&
          item.produto == produto.idProduto) {
        itemExistente = item;
        break;
      }
    }

    final quantidadeAtual = itemExistente?.quantidade ?? 0;
    final novaQuantidade = quantidadeAtual + quantidade;

    if (novaQuantidade > produto.estoque) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Estoque insuficiente. Disponível: ${produto.estoque}. Já no carrinho: $quantidadeAtual.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (itemExistente == null) {
      final novoItem = ItemCarrinho(
        carrinho: carrinhoAtual.idCarrinho!,
        produto: produto.idProduto!,
        quantidade: quantidade,
        precoUnitario: produto.preco,
      );

      await itemService.addItem(novoItem);
    } else {
      final itemAtualizado = ItemCarrinho(
        idItemCarrinho: itemExistente.idItemCarrinho,
        carrinho: itemExistente.carrinho,
        produto: itemExistente.produto,
        quantidade: novaQuantidade,
        precoUnitario: itemExistente.precoUnitario,
      );

      await itemService.updateItem(itemAtualizado);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${produto.nome} adicionado ao carrinho'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
