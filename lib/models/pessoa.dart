import 'dart:convert';

class Pessoa {
  String nome;
  int numChegada;
  Pessoa(this.nome, this.numChegada);

  String toJson() => jsonEncode({
        'nome': nome,
        'numChegada': numChegada,
      });

  factory Pessoa.fromJson(Map json) {
    return Pessoa(json['nome'], json['numChegada']);
  }
}
