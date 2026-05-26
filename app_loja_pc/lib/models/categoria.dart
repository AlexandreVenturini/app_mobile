class Categoria {
  final int idCategoria;
  final String nome;

  Categoria({required this.idCategoria, required this.nome});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(idCategoria: json['idCategoria'], nome: json['nome']);
  }
}
