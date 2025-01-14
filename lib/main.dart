import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'app/pages/home.dart';
import 'app/pages/login.dart';
import 'app/pages/cadastro.dart';
import 'app/pages/cardapio.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/cardapio',
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => LoginApp(),
        '/cadastro': (context) => CadastroScreen(),
        '/cardapio': (context) => Cardapio(),
      },
    );
  }
}
