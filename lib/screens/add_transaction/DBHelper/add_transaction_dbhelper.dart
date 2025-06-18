import 'package:my_pfd/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/category_model.dart';
import '../../../model/transaction_model.dart';

class AddTransactionDbhelper {
  final DBHelper _dbHelper = DBHelper.instance;

  Future<int> addNewTransaction(
    double amount,
    String description,
    String category,
    String date,
    bool isIncome,
  ) async {
    final db = await _dbHelper.database;
    int insertedRowCount = await db.insert("transactions", {
      "amount": amount,
      "description": description,
      "category": category,
      "date": date,
      "isIncome": isIncome ? 1 : 0,
    });

    return insertedRowCount;
  }

  Future<List<TransactionModel>> getAllTransactionsFromDB() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query("transactions");
    // if(maps.isNotEmpty){
    //   print("dddddddddddddddddd");
    //   print(maps);
    // }
    return maps.map((map) => TransactionModel.fromJson(map)).toList();
  }

  Future<List<TransactionModel>> getAllIncomeTransactionsFromDB() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      "transactions",
      where: "isIncome = ?",
      whereArgs: [1],
    );

    return maps.map((map) => TransactionModel.fromJson(map)).toList();
  }

  Future<List<TransactionModel>> getAllExpanseTransactionsFromDB() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      "transactions",
      where: "isIncome = ?",
      whereArgs: [0],
    );

    return maps.map((map) => TransactionModel.fromJson(map)).toList();
  }


  // get all transection of specific month-year like june 2025
  Future<List<TransactionModel>> getTransactionsByMonthYearFromDB(int month, int year) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      where: "strftime('%m', date) = ? AND strftime('%Y', date) = ?",
      whereArgs: [
        month.toString().padLeft(2, '0'), // e.g., 6 -> '06'
        year.toString(), // e.g., 2025
      ],
    );

    return maps.map((map) => TransactionModel.fromJson(map)).toList();
  }



}
