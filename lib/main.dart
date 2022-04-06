import 'package:flutter/cupertino.dart';
import 'package:redis_flutter/app.dart';
import 'package:redis_flutter/setup_getit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Criação das dependências do projeto
  setupDependencies();
  // Executar o app
  runApp(const App());
}
