import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:muscle_dairay/Note.dart';

class DBProvider {
  final _databaseName = "Note.db";
  final _databaseVersion = 1;
  final dbpath = getDatabasesPath();
  
  // make this singleton class
  static final DBProvider _instance = DBProvider._();
  factory DBProvider() {
    return _instance;
  }
  DBProvider._();
  late Database? _database;
  Future<Database> get database async {
    _database = await _initDatabase();
    return _database!;
  }

  //this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE note(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date String,
            category String,
            exercise String,
            weight INTERGER
            ) '''         
        );
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  // function to add data into the database.
  Future<void> addNote(Note note) async {
    final db = await database;
    await db.insert(
      'note',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // function to delete data form the database.
  Future<int> deleteNote(int id) async {
    final db = await database;
    int result = await db.delete(
      'note',
      where: 'id == ?',
      whereArgs: [id],
    );
    return result;
  }

 Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('note', orderBy: "id DESC");
    return List.generate(maps.length, (index) {
      return Note(
        date: maps[index]['date'],
        category: maps[index]['category'],
        exercise: maps[index]['exercise'],
        weight: maps[index]['weight']
      );
    });
  }

   Future<void> updateNote(int id, String category, String exercise, int weight) async {
    final db = await database;
    await db.update(
      'note',
      {'category': category, 'exercise': exercise, 'weight': weight},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
