import 'package:get_it/get_it.dart';
import 'package:redis_flutter/repositories/redis_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Registra RedisRepository como singleton
  getIt.registerLazySingleton(() => RedisRepository());
}
