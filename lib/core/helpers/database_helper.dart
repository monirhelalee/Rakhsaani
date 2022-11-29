import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rakhsaani/features/bookmarks/model/bookmark_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'bookmarks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookmarks(
          id INTEGER PRIMARY KEY,
          surahNumber INTEGER
      )
      ''');
  }

  Future close() async {
    Database? db = await instance.database;
    db = null;
    return db!.close();
  }

  Future<void> addBookmark(Bookmark bookmark) async {
    Database db = await instance.database;
    await db.insert(
      "bookmarks",
      bookmark.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Bookmark>> getBookmarks() async {
    Database db = await instance.database;
    var bookmarks = await db.query("bookmarks");

    List<Bookmark> bookmarkList = bookmarks.isNotEmpty
        ? bookmarks.map((e) => Bookmark.fromMap(e)).toList()
        : [];
    return bookmarkList;
  }

  Future<void> deleteBookmark(int surahNumber) async {
    Database db = await instance.database;
    await db.delete(
      "bookmarks",
      where: 'surahNumber = ?',
      whereArgs: [surahNumber],
    );
  }
}
