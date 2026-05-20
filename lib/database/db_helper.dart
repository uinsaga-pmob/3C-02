import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class DBHelper {
  static final DBHelper instance = DBHelper();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'taskuy.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tugas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            mataKuliah TEXT,
            jenisTugas TEXT,
            deskripsi TEXT,
            deadline TEXT,
            selesai INTEGER
          )
        ''');
      },
    );
  }

  // CREATE
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert('tugas', task.toMap());
  }

  // READ
  Future<List<Task>> getTasks() async {
    final db = await database;
    final result = await db.query('tugas');

    return result.map((e) => Task.fromMap(e)).toList();
  }

  // UPDATE
  Future<int> updateTask(Task task) async {
    final db = await database;

    return await db.update(
      'tugas',
      task.toMap(),
      where: 'id=?',
      whereArgs: [task.id],
    );
  }

  // DELETE
  Future<int> deleteTask(int id) async {
    final db = await database;

    return await db.delete(
      'tugas',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}