import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../model/transaction_model.dart';
import '../controller/transaction_list_screen_controller.dart';

class TransactionListScreen extends StatelessWidget {
  TransactionListScreen({super.key});

  final TransactionListScreenController transactionListScreenController = Get.put(TransactionListScreenController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text("Transactions",style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              transactionListScreenController.selectedSortOption.value = value;
            },
            itemBuilder: (context) {
              return transactionListScreenController.sortOptions.map((option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Obx(() => Row(
                    children: [
                      Radio<String>(
                        value: option,
                        groupValue: transactionListScreenController.selectedSortOption.value,
                        onChanged: (val) {
                          transactionListScreenController.selectedSortOption.value = val!;
                          Navigator.pop(context);
                        },
                      ),
                      Text(option),
                    ],
                  )),
                );
              }).toList();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Filter Buttons: All, Income, Expense
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: transactionListScreenController.options.map((option) {
                final isSelected = transactionListScreenController.selectedOption.value == option;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
                    label: Text(option),
                    selected: isSelected,
                    selectedColor: Colors.green,
                    onSelected: (_) => transactionListScreenController.selectedOption.value = option,
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  ),
                );
              }).toList(),
            )),
            const SizedBox(height: 10),

            // Summary
            Obx(() => Card(
              elevation: 2,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Summary ",style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),),
                        Text("Total Income: ₹${transactionListScreenController.totalIncome.value.toStringAsFixed(2)}"),
                        Text("Total Expense: ₹${transactionListScreenController.totalExpense.value.toStringAsFixed(2)}"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Net Balance: ₹${transactionListScreenController.netBalance.value.toStringAsFixed(2)}"),
                        Text("Transactions: ${transactionListScreenController.totalTransactions.value}"),
                      ],
                    ),
                  ],
                ),
              ),
            )),

            SizedBox(height: 5,),

            // Transactions
            Obx(() {
              List<TransactionModel> filteredList;
              if (transactionListScreenController.selectedOption.value == 'All') {
                filteredList = transactionListScreenController.allTransactionList;
              } else if (transactionListScreenController.selectedOption.value == 'Income') {
                filteredList = transactionListScreenController.allIncomeTransactionList;
              } else {
                filteredList = transactionListScreenController.allExpanseTransactionList;
              }

              final sortedList = transactionListScreenController.sortTransactions(filteredList);

              if (sortedList.isEmpty) {
                return const Center(child: Text("No transactions available."));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sortedList.length,
                itemBuilder: (context, index) {
                  final t = sortedList[index];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      leading: CircleAvatar(
                        backgroundColor: t.isIncome ? Colors.green.shade100 : Colors.red.shade100,
                        child: Icon(
                          t.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                          color: t.isIncome ? Colors.green.shade800 : Colors.red.shade800,
                        ),
                      ),
                      title: Text(t.description),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.category),
                          Text(
                            DateFormat('dd-MM-yyyy').format(DateTime.parse(t.date)),
                          ),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "₹${t.amount.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: t.isIncome ? Colors.green.shade800 : Colors.red.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(t.isIncome ? "Income" : "Expense"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../model/transaction_model.dart';
// import '../controller/transaction_list_screen_controller.dart';
//
// class TransactionListScreen extends StatelessWidget {
//   TransactionListScreen({super.key});
//
//   TransactionListScreenController transactionListScreenController = Get.put(
//     TransactionListScreenController(),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         foregroundColor: Colors.white,
//         title: const Text('Transactions'),
//
//
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Obx(
//                     () => Wrap(
//                       spacing: 10, // horizontal space between items
//                       runSpacing: 10, // vertical space between lines
//                       children:
//                           transactionListScreenController.options.map((option) {
//                             final isSelected =
//                                 transactionListScreenController
//                                     .selectedOption
//                                     .value ==
//                                 option;
//                             return GestureDetector(
//                               onTap: () {
//                                 transactionListScreenController
//                                     .selectedOption
//                                     .value = option;
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 20,
//                                   vertical: 10,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color:
//                                       isSelected
//                                           ? Colors.green
//                                           : Colors.grey.shade200,
//                                   borderRadius: BorderRadius.circular(8),
//                                   border: Border.all(
//                                     color:
//                                         isSelected ? Colors.green : Colors.grey,
//                                   ),
//                                 ),
//                                 child: Row(
//                                   mainAxisSize:
//                                       MainAxisSize.min, // shrink to fit content
//                                   children: [
//                                     if (isSelected)
//                                       Icon(Icons.done, color: Colors.white),
//                                     if (isSelected) const SizedBox(width: 5),
//                                     Text(
//                                       option,
//                                       style: TextStyle(
//                                         color:
//                                             isSelected
//                                                 ? Colors.white
//                                                 : Colors.black54,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                     ),
//                   ),
//                 ),
//
//
//
//
//
//
//               ],
//             ),
//
//
//             Expanded(
//               child: Obx(
//                 () => FutureBuilder<List<TransactionModel>>(
//                   future:
//                       transactionListScreenController.selectedOption.value ==
//                               "All"
//                           ? transactionListScreenController.getAllTransaction()
//                           : transactionListScreenController
//                                   .selectedOption
//                                   .value ==
//                               "Income"
//                           ? transactionListScreenController
//                               .getAllIncomeTransaction()
//                           : transactionListScreenController
//                               .getAllExpanseTransaction(),
//
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text("Error: ${snapshot.error}"));
//                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(child: Text("No transaction yet"));
//                     }
//
//                     final transactions = snapshot.data!;
//
//                     return Column(
//                       children: [
//                         Card(
//                           elevation: 2,
//                           margin: EdgeInsets.only(top: 10, bottom: 20),
//                           color: Colors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Obx(
//                                       () => Text(
//                                         "Total Income: ₹${transactionListScreenController.totalIncome.value}",
//                                       ),
//                                     ),
//                                     Obx(
//                                       () => Text(
//                                         "Total Expense: ₹${transactionListScreenController.totalExpense.value}",
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Obx(
//                                       () => Text(
//                                         "Net Balance: ₹${transactionListScreenController.netBalance.value}",
//                                       ),
//                                     ),
//                                     Obx(
//                                       () => Text(
//                                         "Total Transactions: ${transactionListScreenController.totalTransactions.value}",
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: transactions.length,
//                             itemBuilder: (context, index) {
//                               final transaction = transactions[index];
//                               return Card(
//                                 elevation: 2,
//                                 child: ListTile(
//                                   tileColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   leading: CircleAvatar(
//                                     backgroundColor:
//                                         transaction.isIncome
//                                             ? Colors.green.shade50
//                                             : Colors.red.shade50,
//                                     radius: 20,
//                                     child: Icon(
//                                       transaction.isIncome
//                                           ? Icons.arrow_upward
//                                           : Icons.arrow_downward,
//                                       color:
//                                           transaction.isIncome
//                                               ? Colors.green.shade900
//                                               : Colors.red.shade900,
//                                     ),
//                                   ),
//                                   title: Text(transaction.description),
//                                   subtitle: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(transaction.category),
//                                       Text(transaction.date),
//                                     ],
//                                   ),
//                                   trailing: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         "₹${transaction.amount.toStringAsFixed(2)}",
//                                         style: TextStyle(
//                                           color:
//                                               transaction.isIncome
//                                                   ? Colors.green.shade900
//                                                   : Colors.red.shade900,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       Text(
//                                         transaction.isIncome
//                                             ? "Income"
//                                             : "Expense",
//                                         style: TextStyle(
//                                           color:
//                                               transaction.isIncome
//                                                   ? Colors.green.shade900
//                                                   : Colors.red.shade900,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
