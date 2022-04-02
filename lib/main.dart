import 'package:flutter/cupertino.dart';
import 'package:redis_flutter/app.dart';
import 'package:redis_flutter/setup_getit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(const App());
}
