import 'dart:io';
import 'package:booktracer/model/book.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'columns.dart';

// singleton class to manage the database
class DatabaseHelper with ChangeNotifier {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "books.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableBooks (
                $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
                $columnTitle TEXT NOT NULL,
                $columnStartDate INTEGER NOT NULL,
                $columnEndDate INTEGER,
                $columnPageNumber INTEGER NOT NULL,
                $columnTotalPageNumber INTEGER NOT NULL,
                $columnIsDone INTEGER NOT NULL
              )
              ''');
    notifyListeners();
  }

  // Database helper methods:

  Future<Book> insert(Book book) async {
    Database db = await database;
    book.id = await db.insert(tableBooks, book.toMap());
    return book;
  }

  Future<Book> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableBooks,
        columns: [
          columnId,
          columnTitle,
          columnStartDate,
          columnEndDate,
          columnPageNumber,
          columnTotalPageNumber,
          columnIsDone
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Book.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> queryTable(String table) async {
    Database db = await database;
    return await db.query(table);
  }

  Future<int> deleteById(int id) async {
    Database db = await instance.database;
    return await db.delete(tableBooks, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> deleteAllRows() async {
    Database db = await instance.database;
    await db.execute("delete from $tableBooks");
    notifyListeners();
  }

  Future<int> updateBook(Book book) async {
    Database db = await instance.database;
    int value = await db.update(tableBooks, book.toMap(),
        where: '$columnId = ?', whereArgs: [book.id]);
    notifyListeners();
    return value;
  }
}
