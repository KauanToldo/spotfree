// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project/database/dao/db_query.dart';
import 'package:project/model/usuario.dart';
import 'package:project/screens/telaInicial.dart';
import 'package:project/screens/telaLogin.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _controllerSenha = TextEditingController();
  final TextEditingController _controllerUsuario = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  void checkCadastro() {
    // Verificar campos vazios
    if (_controllerEmail.text == "" ||
        _controllerUsuario.text == "" ||
        _controllerSenha.text == "") {
      return;
    }

    // Verificar usuário já existente
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          scale: 3.5,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Entrar no Spotfree",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                        TextField(
                          controller: _controllerEmail,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: false,
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Text(
                          "Nome de usuário",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                        TextField(
                          controller: _controllerUsuario,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: false,
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Text(
                          "Senha",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        TextField(
                            controller: _controllerSenha,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: false,
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            )),
                        const SizedBox(height: 16.0),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              checkCadastro();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 30, 215, 96),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Já tem uma conta?',
                              style: TextStyle(color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 30, 215, 96),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          Color.fromARGB(255, 30, 215, 96)),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 80),
                    const Column(
                      children: [
                        Text(
                          "Made by @toldokauan & @lynxmaah",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
