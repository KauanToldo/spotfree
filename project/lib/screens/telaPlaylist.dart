// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project/database/dao/db_query.dart';
import 'package:project/screens/telaMusica.dart';

class TelaPlaylist extends StatefulWidget {
  final String namePlaylist;
  final Uint8List capaPlaylist;
  final int idPlaylist;

  const TelaPlaylist(
      {super.key,
      required this.namePlaylist,
      required this.capaPlaylist,
      required this.idPlaylist});

  @override
  State<TelaPlaylist> createState() => _TelaPlaylistState();
}

class _TelaPlaylistState extends State<TelaPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
        child: Center(
          child: Column(
            children: [
              Image.memory(
                widget.capaPlaylist,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.namePlaylist,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  IconButton.filled(
                    iconSize: 40,
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    color: Colors.white,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 30, 215, 16)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Expanded(
                child: FutureBuilder(
                  initialData: const [],
                  future: getMusicsByPlaylist(widget.idPlaylist),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => TelaMusica(
                                            nameMusic: dados[index]['nome'],
                                            autorMusic: dados[index]['autor'],
                                            capaMusic: dados[index]['capa'],
                                            namePlaylist:
                                                widget.namePlaylist))));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                                child: Row(
                                  children: [
                                    Image.memory(
                                      capaBytes!,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dados[index]['nome'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(dados[index]['autor'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 14, 14, 14),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Column(
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
