import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/category_model.dart';
import '../../categories/DBHelper/categories_dbhelper.dart';
import '../../transactionList/controller/transaction_list_screen_controller.dart';
import '../DBHelper/add_transaction_dbhelper.dart';

class AddTransactionController extends GetxController {


  final CategoriesDbhelper _categoriesDbhelper = CategoriesDbhelper();
  final AddTransactionDbhelper _addTransactionDbhelper = AddTransactionDbhelper();

  RxList<Category> allCategoriesList = <Category>[].obs;

  final RxBool isIncome=false.obs;

  TextEditingController transactionAmountController=TextEditingController();
  TextEditingController transactionDescriptionController=TextEditingController();

  final RxString selectedCategory = ''.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;




  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    try {
      final categoryList = await _categoriesDbhelper.getAllCategoriesFromDB();
      allCategoriesList.value = categoryList;
    } catch (e) {
      print(e);
    }
  }


  Future<void> addNewTransaction(double amount,String description,String category,String date ,bool isIncome) async {
    try {
      int insertedRowCount = await _addTransactionDbhelper.addNewTransaction(amount,description,category,date ,isIncome);


      if (insertedRowCount > 0) {
        Get.snackbar("Inserted", "Transaction is inserted...");

        // Refresh the transaction list if it exists
        if (Get.isRegistered<TransactionListScreenController>()) {
          final transactionController = Get.find<TransactionListScreenController>();
          await transactionController.refreshTransactions();
        }


        clearAllFields();
      } else {
        Get.snackbar("Error", "Transaction is not inserted...");
      }
    } catch (e) {
      print(e);
    }
  }

  void clearAllFields() {
    transactionAmountController.clear();
    transactionDescriptionController.clear();
    selectedCategory.value = '';
    selectedDate.value = DateTime.now();
    isIncome.value = true; // or false, depending on your default
  }




}