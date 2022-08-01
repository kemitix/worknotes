import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknotes/src/client/client.dart';

import 'src/app.dart';
import 'src/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final sl = await di.init(sharedPreferences: sharedPreferences);
  final client = ClientTrello();
  runApp(App(sl: sl, client: client));
}
