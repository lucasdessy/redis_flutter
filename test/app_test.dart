import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redis_flutter/app.dart';
import 'package:redis_flutter/blocs/queue/queue_cubit.dart';
import 'package:redis_flutter/setup_getit.dart';

void main() {
  testWidgets('Should provide Cubits to its children ...', (tester) async {
    setupDependencies();
    await tester.pumpWidget(const App());
    final BuildContext context = tester.element(find.byType(MaterialApp));
    final cubit = BlocProvider.of<QueueCubit>(context);
    expect(cubit, isNotNull);
  });
}
