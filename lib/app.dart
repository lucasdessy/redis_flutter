import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redis_flutter/blocs/queue/queue_cubit.dart';
import 'package:redis_flutter/repositories/redis_repository.dart';
import 'package:redis_flutter/setup_getit.dart';
import 'package:redis_flutter/views/home_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Injeta QueueCubit no contexto da widget tree
        BlocProvider(
      create: (context) => QueueCubit(getIt<RedisRepository>()),
      child: MaterialApp(
        // Cria a HomeView
        home: HomeView(),
      ),
    );
  }
}
