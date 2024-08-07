// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:project/database/dao/db_query.dart';
// import 'package:project/model/usuario.dart';
import 'package:project/screens/telaInicial.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _lembrarDeMim = false;
  final TextEditingController _controllerSenha = TextEditingController();
  final TextEditingController _controllerUsuario = TextEditingController();

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
                        Row(
                          children: [
                            Switch(
                              value: _lembrarDeMim,
                              onChanged: (value) {
                                setState(() {
                                  _lembrarDeMim = value;
                                });
                              },
                              activeColor:
                                  const Color.fromARGB(255, 30, 215, 96),
                            ),
                            const Text(
                              'Lembrar de mim',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_controllerUsuario.text == "Kauan Toldo" &&
                                  _controllerSenha.text == "123") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TelaInicial()));
                              }
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
                      ],
                    ),
                    const SizedBox(height: 125),
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
