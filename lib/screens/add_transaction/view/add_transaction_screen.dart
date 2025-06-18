import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfd/screens/add_transaction/controller/add_transaction_controller.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  AddTransactionController addTransactionController = Get.put(
    AddTransactionController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text("Add Transactions",style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Text(
                          "Select Transaction Type",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //           horizontal: 10,
                      //           vertical: 5,
                      //         ),
                      //         child: Card(
                      //           color: Colors.white,
                      //           elevation: 2,
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(10),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Padding(
                      //                   padding: const EdgeInsets.symmetric(
                      //                     horizontal: 10,
                      //                     vertical: 10,
                      //                   ),
                      //                   child: Row(
                      //                     children: [
                      //                       Icon(
                      //                         Icons.arrow_upward,
                      //                         color: Colors.green,
                      //                       ),
                      //                       SizedBox(width: 5),
                      //                       Text("Income"),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //           horizontal: 10,
                      //           vertical: 5,
                      //         ),
                      //         child: Card(
                      //           color: Colors.white,
                      //           elevation: 2,
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(10),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Padding(
                      //                   padding: const EdgeInsets.symmetric(
                      //                     horizontal: 10,
                      //                     vertical: 10,
                      //                   ),
                      //                   child: Row(
                      //                     children: [
                      //                       Icon(
                      //                         Icons.arrow_downward,
                      //                         color: Colors.green,
                      //                       ),
                      //                       SizedBox(width: 5),
                      //                       Text("Expense"),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Income Card
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  addTransactionController.isIncome.value = true;
                                },
                                child: Obx(
                                  () => Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            addTransactionController
                                                    .isIncome
                                                    .value
                                                ? Colors.green.shade900
                                                : Colors.grey.shade400,
                                        width: 2,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_upward,
                                          color:addTransactionController
                                              .isIncome
                                              .value
                                              ? Colors.green.shade900
                                              : Colors.grey.shade400,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Income",
                                          style: TextStyle(
                                            color: addTransactionController
                                                .isIncome
                                                .value
                                                ? Colors.green.shade900
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Expense Card
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  addTransactionController.isIncome.value = false;
                                },
                                child: Obx(
                                  () => Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            !addTransactionController
                                                    .isIncome
                                                    .value
                                                ? Colors.red.shade900
                                                : Colors.grey.shade400,
                                        width: 2,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_downward,
                                          color: !addTransactionController
                                              .isIncome
                                              .value
                                              ? Colors.red.shade900
                                              : Colors.grey.shade400,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Expense",
                                          style: TextStyle(
                                            color: !addTransactionController
                                                .isIncome
                                                .value
                                                ? Colors.red.shade900
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),

              TextField(
                controller: addTransactionController.transactionAmountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter amount',
                  prefixText: '₹ ',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),

              SizedBox(height: 16),

              TextField(
                controller:
                    addTransactionController.transactionDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Category',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  // TextButton.icon(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.add),
                  //   label: const Text('Add Category'),
                  // ),
                ],
              ),

              SizedBox(height: 10,),
              Obx(
                () => DropdownButtonFormField<String>(
                  value:
                      addTransactionController.selectedCategory.isEmpty
                          ? null
                          : addTransactionController.selectedCategory.value,
                  decoration: const InputDecoration(
                    hintText: 'Select category',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  items:
                      addTransactionController.allCategoriesList
                          .map(
                            (category) => DropdownMenuItem<String>(
                              value: category.name,
                              child: Text(category.name),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      addTransactionController.selectedCategory.value = value;
                    }
                  },
                  validator:
                      (value) =>
                          value == null ? 'Please select a category' : null,
                ),
              ),

              const SizedBox(height: 16),

              InkWell(
                onTap: _showDatePicker,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: Obx(
                    () => Text(
                      DateFormat(
                        'dd-MM-yyyy',
                      ).format(addTransactionController.selectedDate.value),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (addTransactionController.transactionAmountController.text
                            .trim()
                            .isNotEmpty &&
                        addTransactionController
                            .transactionDescriptionController
                            .text
                            .trim()
                            .isNotEmpty &&
                        addTransactionController.selectedCategory.value
                            .trim()
                            .isNotEmpty) {
                      print("All fields are filled correctly");

                      addTransactionController.addNewTransaction(
                        double.tryParse(addTransactionController.transactionAmountController.text.trim(),) ?? 0.0,
                        addTransactionController.transactionDescriptionController.text.trim().toString(),
                        addTransactionController.selectedCategory.value.trim().toString(),
                        addTransactionController.selectedDate.toString(),
                        addTransactionController.isIncome.value,
                      );





                    } else {
                      print("Some fields are missing or invalid");
                      Get.snackbar("Error", "Please enter all details...");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save Transaction',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: addTransactionController.selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (selectedDate != null) {
      addTransactionController.selectedDate.value = selectedDate;
    }
  }
}
