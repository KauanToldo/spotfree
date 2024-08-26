// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project/database/dao/db_query.dart';
import 'package:project/database/db.dart';
// import 'package:project/model/music.dart';
// import 'package:project/model/playlist.dart';
import 'package:project/screens/telaPerfil.dart';
import 'package:project/screens/telaPlaylist.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TelaInicial extends StatefulWidget {
  final String nameUser;

  const TelaInicial({super.key, required this.nameUser});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    loadUserImage();
  }

  Future<void> loadUserImage() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> result = await db.query(
      'usuarios',
      where: 'nome = ?',
      whereArgs: [widget.nameUser],
    );

    if (result.isNotEmpty && result[0]['foto'] != null) {
      setState(() {
        imageBytes = result[0]['foto'];
      });
    }
  }

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
                            builder: (context) => TelaPerfil(
                                  nameUser: widget.nameUser,
                                )));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: imageBytes != null
                            ? MemoryImage(imageBytes!)
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.nameUser,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            const Text(
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
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Image.asset(
            "assets/logo_splash.png",
            scale: 9,
          ),
        ),
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
            Center(
              child: SizedBox(
                height: 140,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset('assets/home_top_card.png')),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 60),
                        child: Image.asset("assets/home_artist.png"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Suas Playlists",
              style: TextStyle(
                  color: Color.fromARGB(255, 66, 200, 60),
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
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: dados.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => TelaPlaylist(
                                              namePlaylist: dados[index]
                                                  ['nome'],
                                              capaPlaylist: dados[index]
                                                  ['capa'],
                                              idPlaylist: dados[index]['id'],
                                            ))));
                              },
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/capas/${dados[index]['capa']}",
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        dados[index]['nome'],
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
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
        surfaceTintColor: Colors.transparent,
        color: Color.fromARGB(255, 18, 18, 18),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.library_music,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 35,
              ),
              SizedBox(height: 4),
              Text(
                "Sua Biblioteca",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 12),
              )
            ],
          ),
        ),
      ),
      //
    );
  }
}
