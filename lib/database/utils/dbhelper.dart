import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database? _db;

  Future<Database> checkDB() async {
    if (_db != null) {
      return _db!;
    } else {
      return await createDB();
    }
  }

  Future<Database> createDB() async {
    Directory _folder = await getApplicationDocumentsDirectory();
    String _path = join(_folder.path, 'first.db');
    return openDatabase(_path, version: 1, onCreate: (_db, version) {
      String query =
          'CREATE TABLE std(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, std TEXT, mobile TEXT)';
      _db.execute(query);
    });
  }

  void insertData(
    String n1,
    String s1,
    String m1,
  ) async {
    _db = await checkDB();
    _db!.insert('std', {'name': n1, 'mobile': m1, "std": s1});
  }

  Future<List<Map>> readData() async {
    _db = await checkDB();
    String _query = "SELECT * FROM std";
    List<Map> stdList = await _db!.rawQuery(_query, null);

    return stdList;
  }

  void deleteData(String id) async {
    _db = await checkDB();
    _db!.delete('std', where: 'id = ?', whereArgs: [int.parse(id)]);
  }

  void updateData(String n1, String s1, String m1, String id) async {
    _db = await checkDB();
    _db!.update('std', {'name': n1, 'mobile': m1, "std": s1},
        where: 'id = ?', whereArgs: [int.parse(id)]);
  }
}
