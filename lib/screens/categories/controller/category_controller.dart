import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfd/database/database_helper.dart';

import '../../../model/category_model.dart';
import '../DBHelper/categories_dbhelper.dart';

class CategoryController extends GetxController {
  final CategoriesDbhelper _categoriesDbhelper = CategoriesDbhelper();

  RxList<Category> allCategoriesList = <Category>[].obs;
  RxList<Category> allDefaultCategoriesList = <Category>[].obs;
  RxList<Category> allCustomCategoriesList = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
    getAllDefaultCategories();
    getAllCustomeCategories();
  }

  Future<void> getAllCategories() async {
    try {
      final categoryList = await _categoriesDbhelper.getAllCategoriesFromDB();
      allCategoriesList.value = categoryList;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllDefaultCategories() async {
    try {
      final categoryList =
          await _categoriesDbhelper.getAllDefaultCategoriesFromDB();
      allDefaultCategoriesList.value = categoryList;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllCustomeCategories() async {
    try {
      final categoryList =
          await _categoriesDbhelper.getAllCustomCategoriesFromDB();
      allCustomCategoriesList.value = categoryList;
    } catch (e) {
      print(e);
    }
  }

  Future<void> addNewCategory(String name) async {
    try {
      int insertedRowCount = await _categoriesDbhelper.addNewCategoryName(name);

      getAllCustomeCategories();

      if (insertedRowCount > 0) {
        Get.snackbar("Inserted", "Category is inserted...");
      } else {
        Get.snackbar("Error", "Category is not inserted...");
      }
    } catch (e) {
      print(e);
    }
  }
}
