import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/database/dao/db_query.dart';
import 'package:project/model/music.dart';
import 'package:project/model/playlist.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/usuario.png",
                  scale: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Nome da pessoa",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                )
              ],
            ),
            SizedBox(height: 40.0),
            Text(
              "Playlists de Fulano de Tal",
              style: TextStyle(
                  color: Color.fromARGB(255, 30, 215, 16),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
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
                          return GestureDetector(
                            onTap: () {
                              debugPrint(
                                  "Entrar na playlist ${dados[index]['nome']}");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 46, 42, 42),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  children: [
                                    Image.memory(
                                      capaBytes!,
                                      width: 75,
                                      height: 75,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        dados[index]['nome'],
                                        style: TextStyle(color: Colors.white),
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
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 18, 18, 18),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
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
      ),
    );
  }
}
