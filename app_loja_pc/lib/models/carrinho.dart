class Carrinho {
  final int? idCarrinho;
  final int usuario;
  final double valor;
  final String status;

  Carrinho({
    this.idCarrinho,
    required this.usuario,
    required this.valor,
    required this.status,
  });

  factory Carrinho.fromJson(Map<String, dynamic> json) {
    return Carrinho(
      idCarrinho: json['idCarrinho'],
      usuario: json['usuario'],
      valor: double.parse(json['valor'].toString()),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'usuario': usuario, 'valor': valor, 'status': status};
  }
}
