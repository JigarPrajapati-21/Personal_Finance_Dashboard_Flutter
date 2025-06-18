import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._instance();
  static Database? _db;

  DBHelper._instance();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), "my_pfd.db");

    return await openDatabase(path, version: 1, onCreate: _onCreateTbls);
  }

  Future<void> _onCreateTbls(Database db,int version) async {
    //create transaction table
    await db.execute('''
    CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        description TEXT NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL,
        isIncome INTEGER NOT NULL
    )''');

    // Create categories table
    await db.execute('''
      CREATE TABLE categories(
        name TEXT PRIMARY KEY,
        isCustom INTEGER NOT NULL
      )
    ''');

    List defaultCategories = [
      "Food",
      "Education",
      "Shopping",
      "Entertainment",
      "Healthcare",
      "Transport",
      "Salary",
      "Rent",
      "Utilities",
      "Other",
    ];

    for (var category in defaultCategories) {
      await db.insert("categories", {
        "name":category,
        "isCustom":0,
      });
    }
  }
}
