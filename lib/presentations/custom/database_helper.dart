import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/utils/string_values.dart';

import 'notes.dart';

class DatabaseHelper {
  DatabaseHelper._(); //private constructor

  //singleton, only one object in whole project
  static final DatabaseHelper _instanceObjectOfDatabaseHelper = DatabaseHelper._();

  static Database _database; 

  factory DatabaseHelper.getInstance() => _instanceObjectOfDatabaseHelper;

  //custom getter
  Future<Database> get database async {
    if (_database == null) _database = await initializeDatabase();
    return _database;
  }

  //how initialization works
  Future<Database> initializeDatabase() async {
    print("38");
    Directory directory = await getApplicationDocumentsDirectory();
    var path = directory.path + StringValue.noteDB;
    print("path $path");

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  //  creating table in database
  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${StringValue.noteTable} ('
        '${StringValue.colID} INTEGER PRIMARY KEY AUTOINCREMENT, '
        '${StringValue.colTitle} TEXT,'
        '${StringValue.colDescription} TEXT, '
        '${StringValue.colPriority} INTEGER,'
        '${StringValue.colDate} TEXT'
        ')');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    Future<List<Map<String, dynamic>>> result = db.query(StringValue.noteTable,
        orderBy: '${StringValue.colPriority} ASC');
    return result;
  }

  Future<int> insertNote(Notes note) async {
    print("in insert");
    print(note.toMap());
    Database db = await this.database;
    var result = db.insert(StringValue.noteTable, note.toMap());
    print(result);
    return result;
  }

  Future<int> updateNote(Notes note) async {
    print("in update");
    print(note.toMap());
    Database db = await this.database;
    var result = db.update(StringValue.noteTable, note.toMap(),
        where: '${StringValue.colID} = ?', whereArgs: [note.id]);
    print(result);
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result = db.rawDelete(
        'DELETE FROM ${StringValue.noteTable} where ${StringValue.colID} = $id');
    return result;
  }

  Future clear() async {
    print("clear database");
    Database db = await this.database;
    var result = db.delete(StringValue.noteTable);
    print(result);
  }

  Future<int> countNotes() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery(StringValue.countRows);
    // return Sqflite.firstIntValue(x);
    return x.length;
  }

  // getting data in a list of notes from database
  Future<List<Notes>> getNoteList() async {
    var mapList = await getNoteMapList();
    int count = mapList.length;
    print("length");
    print(count);
    List<Notes> result = List<Notes>();
    for (var i = 0; i < count; i++) {
      print(mapList[i]);
      result.add(Notes.fromMapObject(mapList[i]));
    }
    return result;
  }
}

// private constructor
