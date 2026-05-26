import 'package:flutter/material.dart';
import '../models/carrinho.dart';
import '../models/item_carrinho.dart';
import '../models/produto.dart';
import '../services/carrinho_service.dart';
import '../services/item_carrinho_service.dart';
import '../services/produto_service.dart';

class CarrinhoScreen extends StatefulWidget {
  const CarrinhoScreen({super.key});

  @override
  State<CarrinhoScreen> createState() => _CarrinhoScreenState();
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  final CarrinhoService carrinhoService = CarrinhoService();
  final ItemCarrinhoService itemService = ItemCarrinhoService();
  final ProdutoService produtoService = ProdutoService();

  Carrinho? carrinhoAtual;
  List<ItemCarrinho> itens = [];
  List<Produto> produtos = [];

  bool carregando = true;

  @override
  void initState() {
    super.initState();
    iniciarCarrinho();
  }

  Future<void> iniciarCarrinho() async {
    setState(() {
      carregando = true;
    });

    final carrinhos = await carrinhoService.getCarrinhos();
    final produtosApi = await produtoService.getProdutos();

    if (carrinhos.isNotEmpty) {
      carrinhoAtual = carrinhos.first;
    } else {
      carrinhoAtual = await carrinhoService.createCarrinho(
        Carrinho(usuario: 1, valor: 0, status: 'Aberto'),
      );
    }

    final itensApi = await itemService.getItens();

    setState(() {
      produtos = produtosApi;
      itens = itensApi
          .where((item) => item.carrinho == carrinhoAtual!.idCarrinho)
          .toList();
      carregando = false;
    });
  }

  Produto? buscarProduto(int id) {
    try {
      return produtos.firstWhere((produto) => produto.idProduto == id);
    } catch (e) {
      return null;
    }
  }

  double calcularTotal() {
    double total = 0;

    for (var item in itens) {
      total += item.precoUnitario * item.quantidade;
    }

    return total;
  }

  int quantidadeTotalDoProdutoNoCarrinho(int idProduto) {
    int total = 0;

    for (var item in itens) {
      if (item.produto == idProduto) {
        total += item.quantidade;
      }
    }

    return total;
  }

  Future<void> aumentarQuantidade(ItemCarrinho item) async {
    final produto = buscarProduto(item.produto);
    if (produto == null) return;

    if (item.quantidade >= produto.estoque) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Estoque insuficiente. Disponível: ${produto.estoque}'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final itemAtualizado = ItemCarrinho(
      idItemCarrinho: item.idItemCarrinho,
      carrinho: item.carrinho,
      produto: item.produto,
      quantidade: item.quantidade + 1,
      precoUnitario: item.precoUnitario,
    );

    await itemService.updateItem(itemAtualizado);
    await iniciarCarrinho();
  }

  Future<void> diminuirQuantidade(ItemCarrinho item) async {
    if (item.quantidade > 1) {
      final itemAtualizado = ItemCarrinho(
        idItemCarrinho: item.idItemCarrinho,
        carrinho: item.carrinho,
        produto: item.produto,
        quantidade: item.quantidade - 1,
        precoUnitario: item.precoUnitario,
      );

      await itemService.updateItem(itemAtualizado);
    } else {
      await itemService.deleteItem(item.idItemCarrinho!);
    }

    await iniciarCarrinho();
  }

  Future<void> removerItem(int id) async {
    await itemService.deleteItem(id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removido do carrinho'),
        backgroundColor: Colors.red,
      ),
    );

    await iniciarCarrinho();
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xfff4f6f8),
      appBar: AppBar(
        title: const Text('Carrinho'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: itens.isEmpty
                  ? const Center(
                      child: Text(
                        'Carrinho vazio',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: itens.length,
                      itemBuilder: (context, index) {
                        final item = itens[index];
                        final produto = buscarProduto(item.produto);

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 3,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const Icon(Icons.shopping_bag),
                            title: Text(
                              produto?.nome ?? 'Produto não encontrado',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Preço: R\$ ${item.precoUnitario.toStringAsFixed(2)}\nSubtotal: R\$ ${(item.precoUnitario * item.quantidade).toStringAsFixed(2)}',
                            ),
                            isThreeLine: true,
                            trailing: SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle),
                                    color: Colors.red,
                                    onPressed: () {
                                      diminuirQuantidade(item);
                                    },
                                  ),
                                  Text(
                                    item.quantidade.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle),
                                    color: Colors.green,
                                    onPressed: () {
                                      aumentarQuantidade(item);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.black,
                                    onPressed: () {
                                      removerItem(item.idItemCarrinho!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      'R\$ ${calcularTotal().toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
