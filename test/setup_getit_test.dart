import 'package:flutter_test/flutter_test.dart';
import 'package:redis_flutter/repositories/redis_repository.dart';
import 'package:redis_flutter/setup_getit.dart';

void main() {
  test('setup getit ...', () async {
    setupDependencies();
    var dep1 = getIt<RedisRepository>();
    var dep2 = getIt<RedisRepository>();

    expect(dep1 == dep2, isTrue);
  });
}
