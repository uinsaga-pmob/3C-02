import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class DBHelper {
  static final DBHelper instance = DBHelper();
  static Database? _database;

  // Variabel untuk menyimpan data user yang sedang login
  static String activeUserName = "User Name";
  static String activeUserEmail = "email@example.com";
  static String activeUserFoto = "";

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'taskuy.db');

    return await openDatabase(
      path,
      version: 4, 
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

        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            email TEXT,
            password TEXT,
            fotoPath TEXT
          )
        ''');
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS tugas");
        await db.execute("DROP TABLE IF EXISTS users");

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

        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            email TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

// ==================== OPERASI USER (LOGIN/REGISTER) ====================
  Future<int> registerUser(String nama, String email, String password) async {
    final db = await database;
    return await db.insert('users', {
      'nama': nama,
      'email': email,
      'password': password,
      'fotoPath': '',
    });
  }

  Future<bool> loginUser(String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    
    if (result.isNotEmpty) {
      activeUserName = result.first['nama'] as String;
      activeUserEmail = result.first['email'] as String;
      return true;
    }
    return false;
  }

// Reset Password
  Future<bool> resetPassword(String email, String newPassword) async {
    final db = await database;
    
    // Cek apakah email terdaftar di database
    final cekEmail = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    // Jika email tidak ada, kembalikan nilai false (gagal)
    if (cekEmail.isEmpty) {
      return false;
    }

    // Jika ada, lakukan update password
    await db.update(
      'users',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
    return true; // Berhasil
  }

  // Fungsi baru untuk update foto
  Future<void> updateFotoProfile(String email, String path) async {
    final db = await database;
    await db.update(
      'users',
      {'fotoPath': path},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

// ==================== OPERASI TUGAS ====================
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