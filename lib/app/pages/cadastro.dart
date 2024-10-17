import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => CadastroScreen(),
    ),
  );
}

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  // Chave global para o formulário
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  List<String> emails = [];
  List<String> senhas = [];
  List<String> nomes = [];

  @override
  Widget build(BuildContext context) {
    // Tenta acessar os argumentos de forma segura
    final args = ModalRoute.of(context)?.settings.arguments;

    // Verifica se os argumentos não são nulos antes de fazer o casting
    Map<String, List<String>>? userArgs;
    if (args != null) {
      userArgs = args as Map<String, List<String>>; // Aqui você faz o casting
      nomes = userArgs['nomes']!;
      emails = userArgs['emails']!;
      senhas = userArgs['senhas']!;
    }
    ;

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Atribuindo a chave do formulário
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Campo de Nome
              TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome';
                    }
                    return null;
                  } // Validação do campo
                  ),
              SizedBox(height: 16.0),

              // Campo de E-mail
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o e-mail';
                  }
                  // Validação básica de e-mail
                  String pattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(value)) {
                    return 'Por favor, insira um e-mail válido';
                  }
                  return null;
                }, // Validação do campo
              ),
              SizedBox(height: 16.0),

              // Campo de Senha
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true, // Oculta a senha
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  } else if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                }, // Validação do campo
              ),
              SizedBox(height: 32.0),

              // Campo de Senha
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirme a senha',
                ),
                obscureText: true, // Oculta a senha
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  } else if (_confirmPasswordController.text !=
                      _passwordController.text) {
                    return 'As senhas precisam ser iguais!';
                  } else {
                    return null;
                  }
                }, // Validação do campo
              ),
              SizedBox(height: 32.0),

              // Botão de Cadastro
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      nomes.add(_nameController.text);
                      emails.add(_emailController.text);
                      senhas.add(_passwordController.text);
                    });

                    _nameController.clear();
                    _emailController.clear();
                    _passwordController.clear();
                    // Se o formulário for válido, exibe uma mensagem de sucesso
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Cadastro realizado com sucesso!')),
                    );
                    Navigator.pushNamed(
                      context,
                      '/login',
                      arguments: {
                        'nomes': nomes,
                        'emails': emails,
                        'senhas': senhas,
                      },
                    );
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
