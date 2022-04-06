import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redis_flutter/blocs/queue/queue_cubit.dart';
import 'package:redis_flutter/views/components/pessoas_list.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final pessoaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Procura o cubit que está no contexto da widget tree.
    final queueCubit = context.watch<QueueCubit>();
    final queueState = queueCubit.state;

    return Scaffold(
      appBar: AppBar(title: const Text('Fila')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              controller: pessoaController,
              decoration: const InputDecoration(hintText: 'Digite seu nome...'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final text = pessoaController.text;
                    await queueCubit.addPessoa(text);
                    pessoaController.clear();
                  },
                  child: const Text('Adicionar'),
                ),
                ElevatedButton(
                  onPressed: queueCubit.atender,
                  child: const Text('Atender'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (queueState.pessoas != null)
              PessoasList(pessoas: queueState.pessoas!)
          ],
        ),
      ),
    );
  }
}
