import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_tesis/models/grabacion_model.dart';


class DBService {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "grabaciones.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE grabaciones (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            path TEXT,
            fecha TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertGrabacion(GrabacionModel grabacion) async {
    final db = await database;
    return await db.insert("grabaciones", grabacion.toMap());
  }

  static Future<List<GrabacionModel>> getGrabaciones() async {
    final db = await database;
    final result = await db.query("grabaciones", orderBy: "fecha DESC");
    return result.map((map) => GrabacionModel.fromMap(map)).toList();
  }

  static Future<int> deleteGrabacion(int id) async {
    final db = await database;
    return await db.delete("grabaciones", where: "id = ?", whereArgs: [id]);
  }
}
