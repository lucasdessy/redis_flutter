import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:redis_flutter/models/pessoa.dart';
import 'package:redis_flutter/repositories/redis_repository.dart';

part 'queue_state.dart';

class QueueCubit extends Cubit<QueueState> {
  static const queueName = 'pessoasQueue';
  final RedisRepository redisConnection;
  QueueCubit(this.redisConnection) : super(QueueState.initial()) {
    init();
  }

  Future<void> init() async {
    await redisConnection.init();
    await _updateList();
  }

  Future<void> _updateList() async {
    final pessoasJson = await redisConnection.getList(queueName);
    final pessoas =
        pessoasJson.map((e) => Pessoa.fromJson(jsonDecode(e))).toList();

    emit(QueueState()..pessoas = pessoas);
  }

  Future<void> addPessoa(String nome) async {
    final ultimaPessoaJson = await redisConnection.getLastItemList(queueName);
    late Pessoa pessoa;

    if (ultimaPessoaJson != null) {
      final ultimaPessoa = Pessoa.fromJson(jsonDecode(ultimaPessoaJson));
      pessoa = Pessoa(nome, ultimaPessoa.numChegada + 1);
    } else {
      pessoa = Pessoa(nome, 1);
    }

    await redisConnection.rpush(queueName, pessoa.toJson());

    await _updateList();
  }

  Future<void> atender() async {
    await redisConnection.lpop(queueName);
    await _updateList();
  }
}
