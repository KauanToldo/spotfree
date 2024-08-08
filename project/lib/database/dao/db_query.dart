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

Future<List<Map<String, dynamic>>> findidmusics(id) async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> dados =
      await db.query('playlist_music', where: 'playlist_id = $id');
  return dados;
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

Future<int> deleteplaylist() async {
  Database db = await getDatabase();
  return db.delete('playlist', where: 'id >= 1');
}
