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

Future<int> insertPlayMusic(int id_playlist, int id_music) async {
  Database db = await getDatabase();
  Map<String, dynamic> values = {
    'playlist_id': id_playlist,
    'music_id': id_music,
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

Future<int> deleteplaylist() async {
  Database db = await getDatabase();
  return db.delete('playlist', where: 'id >= 1');
}
