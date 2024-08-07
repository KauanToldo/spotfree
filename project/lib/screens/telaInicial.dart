// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project/database/dao/db_query.dart';
// import 'package:project/model/music.dart';
// import 'package:project/model/playlist.dart';
import 'package:project/screens/telaPerfil.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 36, 36, 36),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TelaPerfil()));
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/usuario.png",
                        scale: 8,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nome",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Text(
                              "Ver perfil",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 182, 182, 182),
                                  fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50.0),
                ListTile(
                  title: const Text(
                    "Sair",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Suas Playlists",
              style: TextStyle(
                  color: Color.fromARGB(255, 30, 215, 16),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: FutureBuilder(
                initialData: const [],
                future: findallplaylist(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: Text(
                            "Houve um erro de conexão com o banco de dados"),
                      );
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                          semanticsLabel: "Carregando...",
                        ),
                      );
                    case ConnectionState.done:
                      List<Map> dados = snapshot.data as List<Map>;
                      return ListView.builder(
                        itemCount: dados.length,
                        itemBuilder: (context, index) {
                          Uint8List? capaBytes =
                              dados[index]['capa'] as Uint8List?;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                debugPrint(
                                    "Entrar na playlist ${dados[index]['nome']}");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 46, 42, 42),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  children: [
                                    Image.memory(
                                      capaBytes!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        dados[index]['nome'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Color.fromARGB(255, 18, 18, 18),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.library_music,
                color: Color.fromARGB(255, 182, 182, 182),
                size: 35,
              ),
              SizedBox(height: 4),
              Text(
                "Sua Biblioteca",
                style: TextStyle(
                    color: Color.fromARGB(255, 182, 182, 182), fontSize: 12),
              )
            ],
          ),
        ),
      ),
      //
    );
  }
}
