import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/aluno.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE aluno(id INTEGER PRIMARY KEY, nome TEXT, curso TEXT, cod TEXT, turma TEXT)');
  }

  Future<int> inserirAluno(Aluno aluno) async {
    var dbClient = await db;
    var result = await dbClient.insert("aluno", aluno.toMap());
    return result;
  }

  Future<List> getAluno() async {
    var dbClient = await db;
    var result = await dbClient.query("aluno",
        columns: ["id", "nome", "curso", "cod", "turma"]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM aluno'));
  }

  Future<Aluno> getAlunos(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("aluno",
        columns: ["id", "nome", "curso", "cod", "turma"],
        where: 'ide = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return new Aluno.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteAluno(int id) async {
    var dbClient = await db;
    return await dbClient.delete("aluno", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateAluno(Aluno aluno) async {
    var dbClient = await db;
    return await dbClient.update("aluno", aluno.toMap(),
        where: "id = ?", whereArgs: [aluno.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
