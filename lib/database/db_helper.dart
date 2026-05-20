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
      version: 2, 
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

      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS tugas");

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

  Future<int> insertTask(Task task) async {
    final db = await database;

    return await db.insert(
      'tugas',
      {
        'mataKuliah': task.mataKuliah,
        'jenisTugas': task.jenisTugas,
        'deskripsi': task.deskripsi,
        'deadline': task.deadline.toIso8601String(),
        'selesai': task.selesai ? 1 : 0,
      },
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final result = await db.query('tugas');

    return result.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await database;

    return await db.update(
      'tugas',
      {
        'mataKuliah': task.mataKuliah,
        'jenisTugas': task.jenisTugas,
        'deskripsi': task.deskripsi,
        'deadline': task.deadline.toIso8601String(),
        'selesai': task.selesai ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await database;

    return await db.delete(
      'tugas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Task>> getTodayTasks() async {
    final allTasks = await getTasks();
    return allTasks.where((t) => t.isToday()).toList();
  }
}