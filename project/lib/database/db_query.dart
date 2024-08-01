import 'package:project/database/db.dart';
import 'package:project/model/music.dart';
import 'package:project/model/playlist.dart';
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

Future<List<Map<String, dynamic>>> findall() async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> dados = await db.query('playlist');
  return dados;
}

Future<int> deleteplaylist() async {
  Database db = await getDatabase();
  return db.delete('playlist', where: 'id >= 1');
}
