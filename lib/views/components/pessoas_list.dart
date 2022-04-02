import 'package:flutter/material.dart';
import 'package:redis_flutter/models/pessoa.dart';

class PessoasList extends StatelessWidget {
  final List<Pessoa> pessoas;
  const PessoasList({required this.pessoas, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const ListTile(
          title: Text('Nome'),
          leading: Text('Núm'),
        ),
        ...pessoas
            .map<Widget>((pessoa) => ListTile(
                  title: Text(pessoa.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  leading: Text(pessoa.numChegada.toString()),
                ))
            .toList()
      ],
    );
  }
}
