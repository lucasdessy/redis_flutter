part of 'queue_cubit.dart';

// Classe que representa o estado do cubit na tela.
class QueueState {
  static QueueState initial() => QueueState();
  List<Pessoa>? pessoas;
  QueueState({List<Pessoa>? pessoas});

  QueueState copyWith({List<Pessoa>? pessoas}) {
    return QueueState(pessoas: pessoas ?? this.pessoas);
  }
}
