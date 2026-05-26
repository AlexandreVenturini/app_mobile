import 'package:flutter/material.dart';
import 'categoria_screen.dart';
import 'produto_list_screen.dart';
import 'carrinho_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget botaoMenu(
    BuildContext context,
    String titulo,
    String subtitulo,
    IconData icone,
    Widget tela,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(18),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icone, color: Colors.white, size: 28),
        ),
        title: Text(
          titulo,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitulo),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => tela));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f6f8),
      appBar: AppBar(
        title: const Text('Loja PC Gamer'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Painel da Loja',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Gerencie produtos, categorias e carrinho.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            botaoMenu(
              context,
              'Categorias',
              'Visualizar categorias cadastradas',
              Icons.category,
              CategoriaScreen(),
            ),
            botaoMenu(
              context,
              'Produtos',
              'Cadastrar, editar e excluir produtos',
              Icons.computer,
              const ProdutoListScreen(),
            ),
            botaoMenu(
              context,
              'Carrinho',
              'Adicionar produtos ao carrinho',
              Icons.shopping_cart,
              const CarrinhoScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
