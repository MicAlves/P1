import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const Home(),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Restaurante da Rosa',
              style: TextStyle(fontSize: 35),
              textAlign: TextAlign.center,
            ),
          ),
          body: Center(
              child: Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Image.asset(
                        'lib/app/images/Logo.png',
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/cadastro');
                              },
                              child: const Text('Novo por aqui? Cadastre-se'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Text('Já tem uma conta? Entrar'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ]),
          ))),
    );
  }
}
