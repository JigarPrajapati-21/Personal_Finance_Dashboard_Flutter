import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/category_controller.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({super.key});

  TextEditingController addCategoryNameController=TextEditingController();
   CategoryController categoryController = Get.put(CategoryController());


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text("Categories",style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addCategoriesDialog,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Default Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              SizedBox(height: 10),
              Text(
                "these categories are built-in and cannot be deleted",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),

              Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3,
                  ),
                  itemCount: categoryController.allDefaultCategoriesList.length,
                  itemBuilder: (context, index) {
                    final category =
                        categoryController.allDefaultCategoriesList[index];
                    return Card(
                      elevation: 2,
                      color: Colors.green.shade100,
                      child: Center(
                        child: Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Custom Categories",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                  // TextButton.icon(
                  //   label: Text("Add"),
                  //   icon: Icon(Icons.add),
                  //   style: TextButton.styleFrom(foregroundColor: Colors.green),
                  //   onPressed: addCategoriesDialog,
                  // ),
                ],
              ),

              // SizedBox(height: 5),
              Text(
                "Custome categories you have created",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),

              Obx(
                () =>
                    (categoryController.allCustomCategoriesList.isNotEmpty)
                        ? GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 3,
                      ),
                      itemCount: categoryController.allCustomCategoriesList.length,
                      itemBuilder: (context, index) {
                        final category =
                        categoryController.allCustomCategoriesList[index];
                        return Card(
                          elevation: 2,
                          color: Colors.green.shade100,
                          child: Center(
                            child: Text(
                              category.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    )
                        : Card(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.category_outlined,
                                    size: 50,
                                    color: Colors.grey[400],
                                  ),
                                  Text(
                                    "No Custome categories",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  // const SizedBox(height: 8),
                                  Text(
                                    'Create custom categories to better organize your transactions',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: addCategoriesDialog,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add Category'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

   Future addCategoriesDialog() {
     return Get.dialog(
       AlertDialog(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
         backgroundColor: Colors.green.shade50,
         title: Row(
           children: [
             Icon(Icons.category, color: Colors.green),
             SizedBox(width: 8),
             Text(
               "Add New Category",
               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
             ),
           ],
         ),
         content: SingleChildScrollView(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               TextField(
                 controller: addCategoryNameController,
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.edit, color: Colors.green),
                   hintText: "Enter category name",
                   filled: true,
                   fillColor: Colors.white,
                   enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.green),
                     borderRadius: BorderRadius.circular(12),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.green, width: 2),
                     borderRadius: BorderRadius.circular(12),
                   ),
                 ),
               ),
             ],
           ),
         ),
         actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
         actions: [
           TextButton.icon(
             onPressed: () {
               Get.back();
               addCategoryNameController.clear();
             },
             icon: Icon(Icons.cancel, color: Colors.green),
             label: Text("Cancel", style: TextStyle(color: Colors.green)),
           ),
           ElevatedButton.icon(
             onPressed: () {
               final name = addCategoryNameController.text.trim();
               if (name.isNotEmpty) {
                 categoryController.addNewCategory(name);
                 addCategoryNameController.clear();
                 Get.back();
               } else {
                 Get.snackbar(
                   "Input Required",
                   "Please enter a category name.",
                   backgroundColor: Colors.red.shade100,
                   colorText: Colors.red.shade900,
                   icon: Icon(Icons.warning, color: Colors.red),
                 );
               }
             },
             icon: Icon(Icons.check),
             label: Text("Add"),
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.green,
               foregroundColor: Colors.white,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12),
               ),
             ),
           ),
         ],
       ),
     );
   }


}
