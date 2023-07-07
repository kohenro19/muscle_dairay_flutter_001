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

  void _createTableV1(Batch batch) {
    batch.execute('''
    CREATE TABLE note(
      no INTERGER,
      category String,
      workout String,
      weight INTERGER
    ) ''');
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
            CREATE TABLE favorite(
            message_no INTERGER,
            message String,
            author String,
            category INTERGER
            ) '''         
        );
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  // function to add data into the database.
  Future<void> insertFavorite(Note note) async {
    final db = await database;
    await db.insert(
      'favorite',
      favorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // function to delete data form the database.
  Future<int> deleteFavorite(int message_no) async {
    final db = await database;
    int result = await db.delete(
      'favorite',
      where: 'message_no == ?',
      whereArgs: [message_no],
    );
    return result;
  }

 Future<List<Note>> read() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorite');
    return List.generate(maps.length, (index) {
      return Note(
        date: maps[index]['date'],
        category: maps[index]['category'],
        exercise: maps[index]['exercise'],
        weight: maps[index]['weight']
      );
    });
  }
}
