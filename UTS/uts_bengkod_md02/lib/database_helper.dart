import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'todo.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'film_list.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE films(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    isDone INTEGER,
    imagePath TEXT
  )
''');
  }

  Future<int> insertFilm(Todo film) async {
    final db = await database;
    return await db.insert('films', film.toMap());
  }

  Future<List<Todo>> getFilms() async {
    final db = await database;
    var res = await db.query('films', orderBy: 'id DESC');
    return res.map((e) => Todo.fromMap(e)).toList();
  }

  Future<List<Todo>> searchFilms(String keyword) async {
    final db = await database;
    var res = await db.query(
      'films',
      where: 'title LIKE ?',
      whereArgs: ['%$keyword%'],
    );
    return res.map((e) => Todo.fromMap(e)).toList();
  }

  Future<int> updateFilm(Todo film) async {
    final db = await database;
    return await db.update(
      'films',
      film.toMap(),
      where: 'id = ?',
      whereArgs: [film.id],
    );
  }

  Future<int> deleteFilm(int id) async {
    final db = await database;
    return await db.delete(
      'films',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCompletedFilms() async {
    final db = await database;
    return await db.delete(
      'films',
      where: 'isDone = ?',
      whereArgs: [1],
    );
  }
}
