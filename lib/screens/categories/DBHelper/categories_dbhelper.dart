import 'package:my_pfd/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/category_model.dart';

class CategoriesDbhelper {
  final DBHelper _dbHelper = DBHelper.instance;

  Future<List<Category>> getAllCategoriesFromDB() async {
    final db = await _dbHelper.database;
    List<Map<String,dynamic>> allCategoriesList = [];

    allCategoriesList =
        await db.query(
          "categories",
          orderBy: 'isCustom ASC, name ASC',
        );
    return  allCategoriesList.map((map) => Category.fromJson(map)).toList();

  }

  Future<List<Category>> getAllDefaultCategoriesFromDB() async {
    final db = await _dbHelper.database;
    List<Map<String,dynamic>> allDefaultCategoriesList = [];

    allDefaultCategoriesList =
    await db.query(
      "categories",
      where: 'isCustom = ?',
      whereArgs: [0],
      orderBy: 'isCustom ASC, name ASC',
    );
    return  allDefaultCategoriesList.map((map) => Category.fromJson(map)).toList();

  }


  Future<List<Category>> getAllCustomCategoriesFromDB() async {
    final db = await _dbHelper.database;
    List<Map<String,dynamic>> allCustomCategoriesList = [];

    allCustomCategoriesList =
    await db.query(
      "categories",
      where: 'isCustom = ?',
      whereArgs: [1],
      orderBy: 'name ASC',
    );
    return  allCustomCategoriesList.map((map) => Category.fromJson(map)).toList();

  }

  Future<int> addNewCategoryName(String name)async{
    final db = await _dbHelper.database;
   int insertedRowCount =await db.insert( "categories", {
      "name": name,
      "isCustom": 1,// 1 is to define custom category
    });

   return insertedRowCount;

  }



}
