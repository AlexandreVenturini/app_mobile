class ItemCarrinho {
  final int? idItemCarrinho;
  final int carrinho;
  final int produto;
  final int quantidade;
  final double precoUnitario;

  ItemCarrinho({
    this.idItemCarrinho,
    required this.carrinho,
    required this.produto,
    required this.quantidade,
    required this.precoUnitario,
  });

  factory ItemCarrinho.fromJson(Map<String, dynamic> json) {
    return ItemCarrinho(
      idItemCarrinho: json['idItemCarrinho'],
      carrinho: json['carrinho'],
      produto: json['produto'],
      quantidade: json['quantidade'],
      precoUnitario: double.parse(json['precoUnitario'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carrinho': carrinho,
      'produto': produto,
      'quantidade': quantidade,
      'precoUnitario': precoUnitario,
    };
  }
}
