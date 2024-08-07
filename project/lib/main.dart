import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
// import 'package:project/model/usuario.dart';
import 'package:project/screens/telaLogin.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:project/database/dao/db_query.dart';
// import 'package:project/model/music.dart';
import 'package:project/model/playlist.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }

  deleteplaylist();

  ByteData sertanejoFile = await rootBundle.load('assets/sertanejo.png');
  Uint8List sertanejoCapa = sertanejoFile.buffer.asUint8List();

  ByteData rapFile = await rootBundle.load('assets/rap.jpg');
  Uint8List rapCapa = rapFile.buffer.asUint8List();

  ByteData luanSantanaFile = await rootBundle.load('assets/luan_santana.png');
  Uint8List luanSantanaCapa = luanSantanaFile.buffer.asUint8List();

  insertPlaylist(Playlist(nome: "Esquenta Sertanejo", capa: sertanejoCapa));
  insertPlaylist(Playlist(nome: "Rap", capa: rapCapa));
  insertPlaylist(Playlist(nome: "Luan Santana", capa: luanSantanaCapa));

  debugPrint(findallusuario().then(
    (value) {
      debugPrint(value.toString());
    },
  ).toString());

  debugPrint(findallplaymusic().then(
    (value) {
      debugPrint(value.toString());
    },
  ).toString());

  runApp(const MaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}
