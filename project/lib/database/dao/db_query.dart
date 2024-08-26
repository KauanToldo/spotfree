import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:project/database/db.dart';
import 'package:project/model/music.dart';
import 'package:project/model/playlist.dart';
import 'package:project/model/usuario.dart';
import 'package:sqflite/sqflite.dart';

Future<int> insertMusic(Music music) async {
  Database db = await getDatabase();
  return db.insert('music', music.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<int> insertPlaylist(Playlist playlist) async {
  Database db = await getDatabase();
  return db.insert('playlist', playlist.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<int> insertUsuario(Usuario usuario) async {
  Database db = await getDatabase();
  return db.insert('usuarios', usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<int> updateFotoUsuario(String nome, Uint8List foto) async {
  Database db = await getDatabase();

  Map<String, dynamic> valores = {
    'foto': foto,
  };

  return db.update(
    'usuarios',
    valores,
    where: 'nome = ?',
    whereArgs: [nome],
  );
}

Future<int> insertPlayMusic(int idPlaylist, int idMusic) async {
  Database db = await getDatabase();
  Map<String, dynamic> values = {
    'playlist_id': idPlaylist,
    'music_id': idMusic,
  };
  return db.insert('playlist_music', values,
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map<String, dynamic>>> findallplaylist() async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> dados = await db.query('playlist');
  return dados;
}

Future<List<Map<String, dynamic>>> findallplaymusic() async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> dados = await db.query('playlist_music');
  return dados;
}

Future<List<Map<String, dynamic>>> getMusicsByPlaylist(int playlistId) async {
  Database db = await getDatabase();

  return await db.rawQuery('''
    SELECT music.* 
    FROM playlist_music
    INNER JOIN music ON playlist_music.music_id = music.id
    WHERE playlist_music.playlist_id = ?
  ''', [playlistId]);
}

Future<List<Map<String, dynamic>>> findallmusic() async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> dados = await db.query('music');
  return dados;
}

Future<List<Map<String, dynamic>>> findallusuario() async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> dados = await db.query('usuarios');
  return dados;
}

Future<bool> checkUserExistByEmail(String email) async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> dados =
      await db.query('usuarios', where: 'email = ?', whereArgs: [email]);
  return dados.isEmpty;
}

Future<List<Map<String, dynamic>>> checkUserExistByName(String nome) async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> dados =
      await db.query('usuarios', where: 'nome = ?', whereArgs: [nome]);
  return dados;
}

Future<bool> isPasswordCorrect(String nome, String senha) async {
  List<Map<String, dynamic>> userData = await checkUserExistByName(nome);

  if (userData.isNotEmpty) {
    String storedPassword = userData.first['senha'];

    if (storedPassword == senha) {
      return true;
    }
  }

  return false;
}

Future<void> insertDados() async {
  //Playlists capas
  // ByteData sertanejoFile = await rootBundle.load('assets/capas/sertanejo.png');
  // Uint8List sertanejoCapa = sertanejoFile.buffer.asUint8List();

  // ByteData rapFile = await rootBundle.load('assets/capas/rap.png');
  // Uint8List rapCapa = rapFile.buffer.asUint8List();

  // ByteData popFile = await rootBundle.load('assets/capas/pop.png');
  // Uint8List popCapa = popFile.buffer.asUint8List();

  //Insert playlists
  insertPlaylist(Playlist(nome: "Esquenta Sertanejo", capa: "sertanejo.png"));

  insertPlaylist(Playlist(nome: "Rap Brasileiro", capa: "rap.png"));

  insertPlaylist(Playlist(nome: "Pop Internacional", capa: "pop.png"));

  //Musicas capas

  // ByteData seuastralfile = await rootBundle.load('assets/capas/seuastral.png');
  // Uint8List seuastralcapa = seuastralfile.buffer.asUint8List();

  // ByteData anjoscantamfile =
  //     await rootBundle.load('assets/capas/anjoscantam.png');
  // Uint8List anjoscantamcapa = anjoscantamfile.buffer.asUint8List();

  // ByteData assumibrasilfile =
  //     await rootBundle.load('assets/capas/assumibrasil.png');
  // Uint8List assumibrasilcapa = assumibrasilfile.buffer.asUint8List();

  // ByteData gostaderuafile =
  //     await rootBundle.load('assets/capas/gostaderua.png');
  // Uint8List gostaderuacapa = gostaderuafile.buffer.asUint8List();

  // ByteData barulhofoguetefile =
  //     await rootBundle.load('assets/capas/barulhofoguete.png');
  // Uint8List barulhofoguetecapa = barulhofoguetefile.buffer.asUint8List();

  // ByteData anestesiadofile =
  //     await rootBundle.load('assets/capas/anestesiado.png');
  // Uint8List anestesiadocapa = anestesiadofile.buffer.asUint8List();

  // ByteData namorandoquerendofile =
  //     await rootBundle.load('assets/capas/namorandoquerendo.png');
  // Uint8List namorandoquerendocapa = namorandoquerendofile.buffer.asUint8List();

  // ByteData naorecomendofile =
  //     await rootBundle.load('assets/capas/naorecomendo.png');
  // Uint8List naorecomendocapa = naorecomendofile.buffer.asUint8List();

  // ByteData suite14file = await rootBundle.load('assets/capas/suite14.png');
  // Uint8List suite14capa = suite14file.buffer.asUint8List();

  // ByteData vazoubraquiarafile =
  //     await rootBundle.load('assets/capas/vazoubraquiara.png');
  // Uint8List vazoubraquiaracapa = vazoubraquiarafile.buffer.asUint8List();

  // ByteData vidalokafile = await rootBundle.load('assets/capas/vidalokapt1.png');
  // Uint8List vidalokacapa = vidalokafile.buffer.asUint8List();

  // ByteData vidalokapt2file =
  //     await rootBundle.load('assets/capas/vidalokapt2.png');
  // Uint8List vidalokapt2capa = vidalokapt2file.buffer.asUint8List();

  // ByteData lealfile = await rootBundle.load('assets/capas/leal.png');
  // Uint8List lealcapa = lealfile.buffer.asUint8List();

  // ByteData bomlugarfile = await rootBundle.load('assets/capas/bomlugar.png');
  // Uint8List bomlugarcapa = bomlugarfile.buffer.asUint8List();

  // ByteData negrodramafile =
  //     await rootBundle.load('assets/capas/negrodrama.png');
  // Uint8List negrodramacapa = negrodramafile.buffer.asUint8List();

  // ByteData allofmefile = await rootBundle.load('assets/capas/allofme.png');
  // Uint8List allofmecapa = allofmefile.buffer.asUint8List();

  // ByteData anotherlovefile =
  //     await rootBundle.load('assets/capas/anotherlove.png');
  // Uint8List anotherlovecapa = anotherlovefile.buffer.asUint8List();

  // ByteData asitwasfile = await rootBundle.load('assets/capas/asitwas.png');
  // Uint8List asitwascapa = asitwasfile.buffer.asUint8List();

  // ByteData firetotherainfile =
  //     await rootBundle.load('assets/capas/firetotherain.png');
  // Uint8List firetotheraincapa = firetotherainfile.buffer.asUint8List();

  // ByteData holdinmebackfile =
  //     await rootBundle.load('assets/capas/holdinmeback.png');
  // Uint8List holdinmebackcapa = holdinmebackfile.buffer.asUint8List();

  // ByteData mercyfile = await rootBundle.load('assets/capas/mercy.png');
  // Uint8List mercycapa = mercyfile.buffer.asUint8List();

  // ByteData seeyouagainfile =
  //     await rootBundle.load('assets/capas/seeyouagain.png');
  // Uint8List seeyouagaincapa = seeyouagainfile.buffer.asUint8List();

  // ByteData someoneyoulovedfile =
  //     await rootBundle.load('assets/capas/someoneyouloved.png');
  // Uint8List someoneyoulovedcapa = someoneyoulovedfile.buffer.asUint8List();

  // ByteData thousandyearsfile =
  //     await rootBundle.load('assets/capas/thousandyears.png');
  // Uint8List thousandyearscapa = thousandyearsfile.buffer.asUint8List();

  // ByteData yourmanfile = await rootBundle.load('assets/capas/yourman.png');
  // Uint8List yourmancapa = yourmanfile.buffer.asUint8List();

  //----------------------Insert musics

  // Sertanejo
  insertMusic(Music(
      nome: "Seu Astral",
      autor: "Jorge e Matheus",
      capa: "seuastral.png",
      nomearquivo: 'seuastral.mp3',
      tamanho: 215));

  insertMusic(Music(
      nome: "Os anjos cantam",
      autor: "Jorge e Matheus",
      capa: "anjoscantam.png",
      nomearquivo: 'anjoscantam.mp3',
      tamanho: 197));

  insertMusic(Music(
      nome: "Te assumi pro brasil",
      autor: "Matheus e Kauan",
      capa: "assumibrasil.png",
      nomearquivo: 'assumibrasil.mp3',
      tamanho: 166));

  insertMusic(Music(
      nome: "Gosta de rua",
      autor: "Felipe e Rodrigo",
      capa: "gostaderua.png",
      nomearquivo: 'gostaderua.mp3',
      tamanho: 175));

  insertMusic(Music(
      nome: "Barulho do Foguete",
      autor: "Zé Neto e Cristiano",
      capa: "barulhofoguete.png",
      nomearquivo: 'barulhofoguete.mp3',
      tamanho: 133));

  insertMusic(Music(
      nome: "Anestesiado",
      autor: "Murilo Huff",
      capa: "anestesiado.png",
      nomearquivo: 'anestesiado.mp3',
      tamanho: 178));

  insertMusic(Music(
      nome: "Ta namorando e me querendo",
      autor: "Henrique e Juliano",
      capa: "namorandoquerendo.png",
      nomearquivo: 'namorandoquerendo.mp3',
      tamanho: 169));

  insertMusic(Music(
      nome: "Não recomendo",
      autor: "Matheus e Kauan",
      capa: "naorecomendo.png",
      nomearquivo: 'naorecomendo.mp3',
      tamanho: 142));

  insertMusic(Music(
      nome: "Suíte 14",
      autor: "Henrique e Diego",
      capa: "suite14.png",
      nomearquivo: 'suite14.mp3',
      tamanho: 179));

  insertMusic(Music(
      nome: "Vazou na braquiara",
      autor: "Hugo e Guilherme",
      capa: "vazoubraquiara.png",
      nomearquivo: 'vazoubraquiara.mp3',
      tamanho: 174));

  // Rap

  insertMusic(Music(
      nome: "Vida loka Pt1",
      autor: "Racionais",
      capa: "vidalokapt1.png",
      nomearquivo: 'vidalokapt1.mp3',
      tamanho: 303));

  insertMusic(Music(
      nome: "Vida loka Pt2",
      autor: "Racionais",
      capa: "vidalokapt2.png",
      nomearquivo: 'vidalokapt2.mp3',
      tamanho: 350));

  insertMusic(Music(
      nome: "Leal",
      autor: "Djonga",
      capa: "leal.png",
      nomearquivo: 'leal.mp3',
      tamanho: 222));

  insertMusic(Music(
      nome: "Um bom lugar",
      autor: "Sabotagem",
      capa: "bomlugar.png",
      nomearquivo: 'bomlugar.mp3',
      tamanho: 305));

  insertMusic(Music(
      nome: "Negro Drama",
      autor: "Racionais",
      capa: "negrodrama.png",
      nomearquivo: 'negrodrama.mp3',
      tamanho: 412));

  //Pop

  insertMusic(Music(
      nome: "All of Me",
      autor: "John Legend",
      capa: "allofme.png",
      nomearquivo: 'allofme.mp3',
      tamanho: 307));

  insertMusic(Music(
      nome: "Another love",
      autor: "Tom Odell",
      capa: "anotherlove.png",
      nomearquivo: 'anotherlove.mp3',
      tamanho: 247));

  insertMusic(Music(
      nome: "As it was",
      autor: "Harry Styles",
      capa: "asitwas.png",
      nomearquivo: 'asitwas.mp3',
      tamanho: 165));

  insertMusic(Music(
      nome: "Set fire to the rain",
      autor: "Adele",
      capa: "firetotherain.png",
      nomearquivo: 'firetotherain.mp3',
      tamanho: 243));

  insertMusic(Music(
      nome: "There's nothin holdin' me back",
      autor: "Shawn Mendes",
      capa: "holdinmeback.png",
      nomearquivo: 'holdinmeback.mp3',
      tamanho: 237));

  insertMusic(Music(
      nome: "Mercy",
      autor: "Shawn Mendes",
      capa: "mercy.png",
      nomearquivo: 'mercy.mp3',
      tamanho: 249));

  insertMusic(Music(
      nome: "See you again",
      autor: "Wiz Khalifa",
      capa: "seeyouagain.png",
      nomearquivo: 'seeyouagain.mp3',
      tamanho: 237));

  insertMusic(Music(
      nome: "Someone you loved",
      autor: "Lewis Capaldi",
      capa: "someoneyouloved.png",
      nomearquivo: 'someoneyouloved.mp3',
      tamanho: 186));

  insertMusic(Music(
      nome: "Thousand years",
      autor: "Christina Perri",
      capa: "thousandyears.png",
      nomearquivo: 'thousandyears.mp3',
      tamanho: 287));

  insertMusic(Music(
      nome: "When I was your man",
      autor: "Bruno Mars",
      capa: "yourman.png",
      nomearquivo: 'yourman.mp3',
      tamanho: 234));

  //Inserts PlayMusics

  insertPlayMusic(1, 1);
  insertPlayMusic(1, 2);
  insertPlayMusic(1, 3);
  insertPlayMusic(1, 4);
  insertPlayMusic(1, 5);
  insertPlayMusic(1, 6);
  insertPlayMusic(1, 7);
  insertPlayMusic(1, 8);
  insertPlayMusic(1, 9);
  insertPlayMusic(1, 10);
  insertPlayMusic(2, 11);
  insertPlayMusic(2, 12);
  insertPlayMusic(2, 13);
  insertPlayMusic(2, 14);
  insertPlayMusic(2, 15);
  insertPlayMusic(3, 16);
  insertPlayMusic(3, 17);
  insertPlayMusic(3, 18);
  insertPlayMusic(3, 19);
  insertPlayMusic(3, 20);
  insertPlayMusic(3, 21);
  insertPlayMusic(3, 22);
  insertPlayMusic(3, 23);
  insertPlayMusic(3, 24);
  insertPlayMusic(3, 25);
}
