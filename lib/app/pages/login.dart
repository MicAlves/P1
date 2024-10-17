import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => LoginApp(),
    ),
  );
}

class LoginApp extends StatelessWidget {
  LoginApp({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Recebe os dados passados via arguments
    final Map<String, List<String>> userArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, List<String>>;
    final List<String> nomes = userArgs['nomes']!;
    final List<String> emails = userArgs['emails']!;
    final List<String> senhas = userArgs['senhas']!;

    final _loginEmailController = TextEditingController();
    final _loginPasswordController = TextEditingController();

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
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'lib/app/images/Logo.png',
                    width: 200,
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 100, 20, 10),
                    child: TextFormField(
                      controller: _loginEmailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Informe seu email',
                        prefixIcon: Icon(Icons.email, size: 24),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _loginPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                    obscureText: true, // Oculta a senha
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a senha';
                      }
                      return null;
                    }, // Validação do campo
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                String email = _loginEmailController.text;
                                String password = _loginPasswordController.text;

                                // Verifica se o email está na lista de emails
                                if (emails.contains(email)) {
                                  // Obtém a posição do email no array
                                  int index = emails.indexOf(email);

                                  // Verifica se a senha na mesma posição do array é correspondente
                                  if (senhas[index] == password) {
                                    Navigator.pushNamed(
                                      context,
                                      '/cardapio',
                                      arguments: {
                                        'nomes': nomes,
                                        'emails': emails,
                                        'senhas': senhas,
                                      },
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Senha incorreta!')),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Email não encontrado!')),
                                  );
                                }
                              },
                              child: const Text('Entrar no app'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/cadastro',
                                  arguments: {
                                    'nomes': nomes,
                                    'emails': emails,
                                    'senhas': senhas,
                                  },
                                );
                              },
                              child: const Text('Novo por aqui? Cadastre-se'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
          ))),
    );
  }
}
