import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/transaction_model.dart';
import '../../add_transaction/DBHelper/add_transaction_dbhelper.dart';

class TransactionListScreenController extends GetxController {

  final AddTransactionDbhelper _addTransactionDbhelper = AddTransactionDbhelper();

  RxList<TransactionModel> allTransactionList = <TransactionModel>[].obs;
  RxList<TransactionModel> allIncomeTransactionList = <TransactionModel>[].obs;
  RxList<TransactionModel> allExpanseTransactionList = <TransactionModel>[].obs;


  final RxString selectedOption = 'All'.obs;
  final List<String> options = ["All", "Income", "Expense"];

  RxDouble totalIncome = 0.0.obs;
  RxDouble totalExpense = 0.0.obs;
  RxDouble netBalance = 0.0.obs;
  RxInt totalTransactions = 0.obs;

  final List<String> sortOptions = [
    'Date (Newest)',
    'Date (Oldest)',
    'Amount (High to Low)',
    'Amount (Low to High)',
  ];

  final RxString selectedSortOption = 'Date (Newest)'.obs;



  @override
  void onInit() {
    super.onInit();
    getAllTransaction();
    getAllIncomeTransaction();
    getAllExpanseTransaction();

  }


  Future<List<TransactionModel>> getAllTransaction() async {
      final transactionList = await _addTransactionDbhelper.getAllTransactionsFromDB();
      allTransactionList.value = transactionList;
      calculateTransactionSummary();
    return allTransactionList;

  }


  Future<List<TransactionModel>> getAllIncomeTransaction() async {

    final transactionList = await _addTransactionDbhelper.getAllIncomeTransactionsFromDB();
    allIncomeTransactionList.value = transactionList;
    return allIncomeTransactionList;
  }


  Future<List<TransactionModel>> getAllExpanseTransaction() async {

    final transactionList = await _addTransactionDbhelper.getAllExpanseTransactionsFromDB();
    allExpanseTransactionList.value = transactionList;
    return allExpanseTransactionList;
  }

  void calculateTransactionSummary() {
    double income = 0.0;
    double expense = 0.0;

    for (var transaction in allTransactionList) {
      if (transaction.isIncome) {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    totalIncome.value = income;
    totalExpense.value = expense;
    netBalance.value = income - expense;
    totalTransactions.value = allTransactionList.length;
  }


  List<TransactionModel> sortTransactions(List<TransactionModel> list) {
    final sortedList = [...list]; // Copy to avoid modifying original

    switch (selectedSortOption.value) {
      case 'Date (Newest)':
        sortedList.sort((a, b) => b.date.compareTo(a.date)); // Assuming date is 'yyyy-MM-dd'
        break;
      case 'Date (Oldest)':
        sortedList.sort((a, b) => a.date.compareTo(b.date));
        break;
      case 'Amount (High to Low)':
        sortedList.sort((a, b) => b.amount.compareTo(a.amount));
        break;
      case 'Amount (Low to High)':
        sortedList.sort((a, b) => a.amount.compareTo(b.amount));
        break;
    }

    return sortedList;
  }



  Future<void> refreshTransactions() async {
    try {
      //  get transactions from DB
      final transactions = await _addTransactionDbhelper.getAllTransactionsFromDB();
      // Update all transaction lists
      allTransactionList.value = transactions;

      // Update filtered lists
      allIncomeTransactionList.value = transactions.where((t) => t.isIncome).toList();
      allExpanseTransactionList.value = transactions.where((t) => !t.isIncome).toList();

      // Recalculate totals
      calculateTransactionSummary();

      print("Transactions refreshed successfully");
    } catch (e) {
      print("Error refreshing transactions: $e");
    }
  }





}