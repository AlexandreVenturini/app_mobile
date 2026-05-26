class Produto {
  final int? idProduto;
  final String nome;
  final String? descricao;
  final double preco;
  final int estoque;
  final int categoria;

  Produto({
    this.idProduto,
    required this.nome,
    this.descricao,
    required this.preco,
    required this.estoque,
    required this.categoria,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      idProduto: json['idProduto'],
      nome: json['nome'],
      descricao: json['descricao'],
      preco: double.parse(json['preco'].toString()),
      estoque: json['estoque'],
      categoria: json['categoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'estoque': estoque,
      'categoria': categoria,
    };
  }
}
