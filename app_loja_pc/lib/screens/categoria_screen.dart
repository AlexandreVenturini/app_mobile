import 'package:flutter/material.dart';
import '../models/categoria.dart';
import '../models/produto.dart';
import '../services/categoria_service.dart';
import '../services/produto_service.dart';
import '../helpers/carrinho_helper.dart';

class CategoriaScreen extends StatefulWidget {
  const CategoriaScreen({super.key});

  @override
  State<CategoriaScreen> createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  final CategoriaService categoriaService = CategoriaService();
  final ProdutoService produtoService = ProdutoService();

  bool carregando = true;
  List<Categoria> categorias = [];
  List<Produto> produtos = [];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      final categoriasApi = await categoriaService.getCategorias();
      final produtosApi = await produtoService.getProdutos();

      setState(() {
        categorias = categoriasApi;
        produtos = produtosApi;
        carregando = false;
      });
    } catch (e) {
      setState(() {
        carregando = false;
      });
    }
  }

  List<Produto> produtosDaCategoria(int idCategoria) {
    return produtos
        .where((produto) => produto.categoria == idCategoria)
        .toList();
  }

  int estoqueTotalCategoria(int idCategoria) {
    final lista = produtosDaCategoria(idCategoria);

    int total = 0;
    for (var produto in lista) {
      total += produto.estoque;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xfff4f6f8),
      appBar: AppBar(
        title: const Text('Categorias e Estoque'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: categorias.isEmpty
          ? const Center(child: Text('Nenhuma categoria cadastrada'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final categoria = categorias[index];
                final listaProdutos = produtosDaCategoria(
                  categoria.idCategoria,
                );
                final estoqueTotal = estoqueTotalCategoria(
                  categoria.idCategoria,
                );

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ExpansionTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.category, color: Colors.white),
                    ),
                    title: Text(
                      categoria.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    subtitle: Text(
                      '${listaProdutos.length} produto(s) | Estoque total: $estoqueTotal',
                    ),
                    children: listaProdutos.isEmpty
                        ? [
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Nenhum produto cadastrado nesta categoria',
                              ),
                            ),
                          ]
                        : listaProdutos.map((produto) {
                            return ListTile(
                              leading: const Icon(Icons.memory),
                              title: Text(produto.nome),
                              subtitle: Text(
                                'R\$ ${produto.preco.toStringAsFixed(2)}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: produto.estoque > 0
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Estoque: ${produto.estoque}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.green,
                                    ),
                                    onPressed: produto.estoque <= 0
                                        ? null
                                        : () async {
                                            await CarrinhoHelper.adicionarProdutoAoCarrinho(
                                              context: context,
                                              produto: produto,
                                            );
                                          },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                  ),
                );
              },
            ),
    );
  }
}
