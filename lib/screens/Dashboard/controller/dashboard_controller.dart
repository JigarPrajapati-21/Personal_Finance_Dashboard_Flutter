import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../model/transaction_model.dart';
import '../../add_transaction/DBHelper/add_transaction_dbhelper.dart';

class DashboardController extends GetxController {

  final AddTransactionDbhelper _addTransactionDbhelper = AddTransactionDbhelper();



  // This holds the current date
  final DateTime currentDate = DateTime.now();

  // This gives you "June 2025" format
   RxString selectedMonthAndYear=''.obs;

   RxList<TransactionModel> monthlyTransactionList=<TransactionModel>[].obs;

  RxDouble totalMonthlyIncome = 0.0.obs;
  RxDouble totalMonthlyExpense = 0.0.obs;
  RxDouble netBalanceMonthly = 0.0.obs;
  RxInt totalMonthlyTransactions = 0.obs;



  @override
  void onInit() {
    super.onInit();
    selectedMonthAndYear.value = DateFormat('MMMM yyyy').format(currentDate);
    print(selectedMonthAndYear.value);
    parseMonthYear(selectedMonthAndYear.value.toString());
  }


  Map<String, int> parseMonthYear(String input) {
    final parts = input.split(' ');
    final monthName = parts[0];
    final year = int.parse(parts[1]);

    final monthNames = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12,
    };

    final month = monthNames[monthName]!;

    getTransactionsByMonthYear(month,year);

    return {'month': month, 'year': year};
  }



  Future<List<TransactionModel>> getTransactionsByMonthYear(int month,int year) async {
    final transactionList = await _addTransactionDbhelper.getTransactionsByMonthYearFromDB(month, year);
    monthlyTransactionList.value = transactionList;
    calculateTransactionSummary();
    return monthlyTransactionList;
  }

  void calculateTransactionSummary() {
    double income = 0.0;
    double expense = 0.0;

    for (var transaction in monthlyTransactionList) {
      if (transaction.isIncome) {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    totalMonthlyIncome.value = income;
    totalMonthlyExpense.value = expense;
    netBalanceMonthly.value = income - expense;
    totalMonthlyTransactions.value = monthlyTransactionList.length;
  }


  Map<String, double> getCategoryWiseExpenses() {
    Map<String, double> dataMap = {};

    for (var transaction in monthlyTransactionList) {
      String category = transaction.category;
      double amount = transaction.amount;

      if (dataMap.containsKey(category)) {
        dataMap[category] = dataMap[category]! + amount;
      } else {
        dataMap[category] = amount;
      }
    }

    return dataMap;
  }

  Map<String, double> getExpenseCategoryData() {
    Map<String, double> dataMap = {};

    for (var t in monthlyTransactionList) {
      if (!t.isIncome) {
        dataMap[t.category] = (dataMap[t.category] ?? 0) + t.amount;
      }
    }

    return dataMap;
  }





}
