import 'package:redis/redis.dart';

// Classe que controla a conexão com o Redis.
class RedisRepository {
  final RedisConnection redisConnection = RedisConnection();
  late Command _command;

  Future<void> init() async {
    _command = await redisConnection.connect('localhost', 6379);
  }

  Future<int> rpush(String key, String value) async {
    return int.parse(
        (await _command.send_object(["rpush", key, value])).toString());
  }

  Future<String?> getLastItemList(String key) async {
    try {
      return List.from(await _command.send_object(["lrange", key, -1, -1]))
          .map<String>((e) => e.toString())
          .toList()[0];
    } catch (err) {
      return null;
    }
  }

  Future<void> lpop(String key) async {
    await _command.send_object(["lpop", key]);
  }

  Future<List<String>> getList(String key) async {
    return List.from(await _command.send_object(["lrange", key, 0, -1]))
        .map<String>((e) => e.toString())
        .toList();
  }

  Future<String?> get(String key) async {
    try {
      return (await _command.send_object(['get', key])).toString();
    } catch (err) {
      return null;
    }
  }

  Future<void> set(String key, dynamic value) async {
    await _command.send_object(['set', key, value]);
  }

  Future<int> incr(String key) async {
    return int.parse((await _command.send_object(['incr', key])).toString());
  }
}
