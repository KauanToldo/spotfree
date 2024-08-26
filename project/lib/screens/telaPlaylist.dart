// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project/database/dao/db_query.dart';
import 'package:project/screens/telaMusica.dart';

class TelaPlaylist extends StatefulWidget {
  final String namePlaylist;
  final String capaPlaylist;
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
  List<Map<String, dynamic>>? listMusics;

  @override
  void initState() {
    super.initState();
    fetchMusics();
  }

  Future<void> fetchMusics() async {
    listMusics = (await getMusicsByPlaylist(widget.idPlaylist))
        as List<Map<String, dynamic>>?;
    setState(() {}); // Atualiza o estado para refletir as mudanças na UI
  }

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
              Image.asset(
                "assets/capas/${widget.capaPlaylist}",
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => TelaMusica(
                                  idPlaylist: widget.idPlaylist,
                                  idMusic: listMusics![0]['id'],
                                  nameMusic: listMusics![0]['nome'],
                                  autorMusic: listMusics![0]['autor'],
                                  capaMusic: listMusics![0]['capa'],
                                  namePlaylist: widget.namePlaylist,
                                  nomearquivo: listMusics![0]['nomearquivo'],
                                  tamanho: listMusics![0]['tamanho']))));
                    },
                    icon: const Icon(Icons.play_arrow),
                    color: Colors.white,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 30, 215, 16)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
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
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => TelaMusica(
                                            idMusic: dados[index]['id'],
                                            idPlaylist: widget.idPlaylist,
                                            nameMusic: dados[index]['nome'],
                                            autorMusic: dados[index]['autor'],
                                            capaMusic: dados[index]['capa'],
                                            namePlaylist: widget.namePlaylist,
                                            nomearquivo: dados[index]
                                                ['nomearquivo'],
                                            tamanho: dados[index]
                                                ['tamanho']))));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/capas/${dados[index]['capa']}",
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
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(dados[index]['autor'],
                                              style: const TextStyle(
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
        color: const Color.fromARGB(255, 18, 18, 18),
        surfaceTintColor: Colors.transparent,
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
