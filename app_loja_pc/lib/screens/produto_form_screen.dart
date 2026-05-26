import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../models/categoria.dart';
import '../services/produto_service.dart';
import '../services/categoria_service.dart';

class ProdutoFormScreen extends StatefulWidget {
  final Produto? produto;

  const ProdutoFormScreen({super.key, this.produto});

  @override
  State<ProdutoFormScreen> createState() => _ProdutoFormScreenState();
}

class _ProdutoFormScreenState extends State<ProdutoFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final precoController = TextEditingController();
  final estoqueController = TextEditingController();

  final ProdutoService produtoService = ProdutoService();
  final CategoriaService categoriaService = CategoriaService();

  List<Categoria> categorias = [];
  int? categoriaSelecionada;

  @override
  void initState() {
    super.initState();
    carregarCategorias();

    if (widget.produto != null) {
      nomeController.text = widget.produto!.nome;
      descricaoController.text = widget.produto!.descricao ?? '';
      precoController.text = widget.produto!.preco.toString();
      estoqueController.text = widget.produto!.estoque.toString();
      categoriaSelecionada = widget.produto!.categoria;
    }
  }

  Future<void> carregarCategorias() async {
    final lista = await categoriaService.getCategorias();

    setState(() {
      categorias = lista;
    });
  }

  Future<void> salvarProduto() async {
    if (!_formKey.currentState!.validate()) return;

    final produto = Produto(
      idProduto: widget.produto?.idProduto,
      nome: nomeController.text,
      descricao: descricaoController.text,
      preco: double.parse(precoController.text.replaceAll(',', '.')),
      estoque: int.parse(estoqueController.text),
      categoria: categoriaSelecionada!,
    );

    if (widget.produto == null) {
      await produtoService.createProduto(produto);
    } else {
      await produtoService.updateProduto(produto);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.produto == null
                ? 'Produto cadastrado com sucesso'
                : 'Produto atualizado com sucesso',
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    precoController.dispose();
    estoqueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.produto != null;

    return Scaffold(
      backgroundColor: const Color(0xfff4f6f8),
      appBar: AppBar(
        title: Text(editando ? 'Editar Produto' : 'Novo Produto'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: categorias.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nomeController,
                          decoration: const InputDecoration(
                            labelText: 'Nome do produto',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe o nome do produto';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: descricaoController,
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: precoController,
                          decoration: const InputDecoration(
                            labelText: 'Preço',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe o preço';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: estoqueController,
                          decoration: const InputDecoration(
                            labelText: 'Estoque',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe o estoque';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          value: categoriaSelecionada,
                          decoration: const InputDecoration(
                            labelText: 'Categoria',
                            border: OutlineInputBorder(),
                          ),
                          items: categorias.map((categoria) {
                            return DropdownMenuItem<int>(
                              value: categoria.idCategoria,
                              child: Text(categoria.nome),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              categoriaSelecionada = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Selecione uma categoria';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: salvarProduto,
                            icon: Icon(editando ? Icons.save : Icons.add),
                            label: Text(
                              editando
                                  ? 'Salvar alterações'
                                  : 'Cadastrar produto',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
