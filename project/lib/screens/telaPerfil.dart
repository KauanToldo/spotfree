// ignore_for_file: file_names, unnecessary_import

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/database/dao/db_query.dart';
import 'package:project/database/db.dart';
import 'package:project/screens/telaPlaylist.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:project/model/music.dart';
// import 'package:project/model/playlist.dart';

class TelaPerfil extends StatefulWidget {
  final String nameUser;

  const TelaPerfil({super.key, required this.nameUser});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final imagePicker = ImagePicker();
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

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      Uint8List imageFileByte = await File(pickedFile.path).readAsBytes();

      await updateFotoUsuario(widget.nameUser, imageFileByte);

      setState(() {
        imageBytes = imageFileByte;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    pick(ImageSource.gallery);
                  },
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        imageBytes != null ? MemoryImage(imageBytes!) : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.nameUser,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                )
              ],
            ),
            const SizedBox(height: 40.0),
            Text(
              'Playlists de ${widget.nameUser}',
              style: const TextStyle(
                  color: Color.fromARGB(255, 66, 200, 60),
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => TelaPlaylist(
                                            namePlaylist: dados[index]['nome'],
                                            capaPlaylist: dados[index]['capa'],
                                            idPlaylist: dados[index]['id'],
                                          ))));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 46, 42, 42),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/capas/${dados[index]['capa']}",
                                      width: 75,
                                      height: 75,
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
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        color: const Color.fromARGB(255, 18, 18, 18),
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
