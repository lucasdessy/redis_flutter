import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:redis_flutter/models/pessoa.dart';
import 'package:redis_flutter/repositories/redis_repository.dart';

part 'queue_state.dart';

class QueueCubit extends Cubit<QueueState> {
  static const queueName = 'pessoasQueue';
  static const queuePosName = 'posicoesQueue';
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

    emit(state.copyWith(pessoas: pessoas));
  }

  Future<void> addPessoa(String nome) async {
    final pessoa = Pessoa(nome, await _getNumChegada());

    await redisConnection.rpush(queueName, pessoa.toJson());

    await _updateList();
  }

  Future<void> atender() async {
    await redisConnection.lpop(queueName);
    await _updateList();
  }

  Future<int> _getNumChegada() async {
    final queuePos = await redisConnection.get(queuePosName);
    late int queuePosNum;
    if (queuePos != null) {
      queuePosNum = await redisConnection.incr(queuePosName);
    } else {
      queuePosNum = 1;
      await redisConnection.set(queuePosName, queuePosNum);
    }
    return queuePosNum;
  }
}
