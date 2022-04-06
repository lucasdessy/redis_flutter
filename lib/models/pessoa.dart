import 'dart:convert';

// Classe para representar a entidade Pessoa
class Pessoa {
  String nome;
  int numChegada;
  Pessoa(this.nome, this.numChegada);
  // Metodo para converter a entidade Pessoa em uma String JSON
  String toJson() => jsonEncode({
        'nome': nome,
        'numChegada': numChegada,
      });

  // Metodo para converter uma String JSON em uma entidade Pessoa
  factory Pessoa.fromJson(Map json) {
    return Pessoa(json['nome'], json['numChegada']);
  }
}
