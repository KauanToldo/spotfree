import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project/model/music.dart';
import 'package:project/screens/telaLogin.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:project/database/dao/db_query.dart';
import 'package:project/model/playlist.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }

  // ByteData sertanejoFile = await rootBundle.load('assets/sertanejo.png');
  // Uint8List sertanejoCapa = sertanejoFile.buffer.asUint8List();

  // ByteData rapFile = await rootBundle.load('assets/rap.jpg');
  // Uint8List rapCapa = rapFile.buffer.asUint8List();

  // ByteData luanSantanaFile = await rootBundle.load('assets/luan_santana.png');
  // Uint8List luanSantanaCapa = luanSantanaFile.buffer.asUint8List();

  // insertPlaylist(Playlist(nome: "Esquenta Sertanejo", capa: sertanejoCapa));
  // insertPlaylist(Playlist(nome: "Rap", capa: rapCapa));
  // insertPlaylist(Playlist(nome: "Luan Santana", capa: luanSantanaCapa));

  // ByteData seuastralfile = await rootBundle.load('assets/seuastral.jpeg');
  // Uint8List seuastralcapa = seuastralfile.buffer.asUint8List();

  // ByteData anjoscantamfile = await rootBundle.load('assets/anjoscantam.jpeg');
  // Uint8List anjoscantamcapa = anjoscantamfile.buffer.asUint8List();

  // ByteData assumibrasilfile = await rootBundle.load('assets/assumibrasil.jpeg');
  // Uint8List assumibrasilcapa = assumibrasilfile.buffer.asUint8List();

  // ByteData vidalokafile = await rootBundle.load('assets/vidaloka.jpeg');
  // Uint8List vidalokacapa = vidalokafile.buffer.asUint8List();

  // ByteData lealfile = await rootBundle.load('assets/leal.jpeg');
  // Uint8List lealcapa = lealfile.buffer.asUint8List();

  // ByteData bomlugarfile = await rootBundle.load('assets/bomlugar.jpeg');
  // Uint8List bomlugarcapa = bomlugarfile.buffer.asUint8List();

  // insertMusic(Music(
  //     nome: "Seu Astral",
  //     autor: "Jorge e Matheus",
  //     capa: seuastralcapa,
  //     nomearquivo: 'seuastral.mp3'));

  // insertMusic(Music(
  //     nome: "Os anjos cantam",
  //     autor: "Jorge e Matheus",
  //     capa: anjoscantamcapa,
  //     nomearquivo: 'anjoscantam.mp3'));

  // insertMusic(Music(
  //     nome: "Te assumi pro brasil",
  //     autor: "Matheus e Kauan",
  //     capa: assumibrasilcapa,
  //     nomearquivo: 'assumibrasil.mp3'));

  // insertMusic(Music(
  //     nome: "Vida loka Pt2",
  //     autor: "Racionais",
  //     capa: vidalokacapa,
  //     nomearquivo: 'vidaloka.mp3'));

  // insertMusic(Music(
  //     nome: "Leal", autor: "Djonga", capa: lealcapa, nomearquivo: 'leal.mp3'));

  // insertMusic(Music(
  //     nome: "Um bom lugar",
  //     autor: "Sabotagem",
  //     capa: bomlugarcapa,
  //     nomearquivo: 'bomlugar.mp3'));

  // insertPlayMusic(1, 1);
  // insertPlayMusic(1, 2);
  // insertPlayMusic(1, 3);
  // insertPlayMusic(2, 4);
  // insertPlayMusic(2, 5);
  // insertPlayMusic(2, 6);

  // debugPrint((await findallmusic()).toString());
  // debugPrint((await findallplaymusic()).toString());
  // debugPrint((await findallplaylist()).toString());
  // debugPrint((await getMusicsByPlaylist(1)).toString());

  runApp(const MaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}
