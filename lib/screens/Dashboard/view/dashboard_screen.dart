import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_pfd/helper/month_selector_controller.dart';
import 'package:my_pfd/screens/Dashboard/controller/dashboard_controller.dart';
import 'package:my_pfd/screens/transactionList/view/transaction_list_screen.dart';
import '../../add_transaction/view/add_transaction_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  MonthSelectorController monthSelectorController = Get.put(
    MonthSelectorController(),
  );

  DashboardController dashboardController = Get.put(DashboardController());

  Future<void> _refresh() async {
    dashboardController.parseMonthYear(
      dashboardController.selectedMonthAndYear.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Icon(
              Icons.account_balance_wallet,
              // size: 60,
              color: Colors.white,
            ),
            Text(
              "Personal Finance Dashboard",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddTransactionScreen())?.then((_) => _refresh());
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),

      body: RefreshIndicator(
        onRefresh: _refresh,
        color: Colors.green,
        child: SingleChildScrollView(
          physics:
              AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works even when content doesn't fill screen
          child: Column(
            children: [
              //month year
              monthYearSelectionCardWidget(),

              // total income and total expense card widget
              totalIncomeAndTotalExpenseCardWidget(),

              //net balance card widget
              netBalanceCardWidget(),

              //  expense pie chart card widget
              expansePieChartCardWidget(),

              // recent transection card widget
              recentTransactionCardWidget(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget monthYearSelectionCardWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    monthSelectorController.previousMonth();
                    dashboardController.selectedMonthAndYear.value =
                        monthSelectorController.formattedMonthYear;
                    dashboardController.parseMonthYear(
                      dashboardController.selectedMonthAndYear.value,
                    );
                  },
                  child: const Icon(Icons.arrow_back_ios),
                ),
                Flexible(
                  child: Text(
                    monthSelectorController.formattedMonthYear,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    monthSelectorController.nextMonth();
                    dashboardController.selectedMonthAndYear.value =
                        monthSelectorController.formattedMonthYear;
                    dashboardController.parseMonthYear(
                      dashboardController.selectedMonthAndYear.value,
                    );
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget totalIncomeAndTotalExpenseCardWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Obx(
              () => Card(
                color: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_upward, color: Colors.green),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                "Total Income",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                " ₹${dashboardController.totalMonthlyIncome.value.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Obx(
              () => Card(
                color: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_downward, color: Colors.red),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                "Total Expense ",
                                style: TextStyle(
                                  // color: Colors.red
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                " ₹${dashboardController.totalMonthlyExpense.value.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget netBalanceCardWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Obx(
        () => Card(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.trending_up, color: Colors.orange),
                    SizedBox(width: 5),
                    Text(
                      "Net Balance",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                Center(
                  child: Text(
                    " ₹${dashboardController.netBalanceMonthly.value.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget expansePieChartCardWidget() {
    return Obx(() {
      final categoryData = dashboardController.getExpenseCategoryData();
      if (categoryData.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Card(
            elevation: 2,
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  "No expense data available",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ),
            ),
          ),
        );
      }

      final total = categoryData.values.fold(0.0, (sum, item) => sum + item);

      // Beautiful color combination - harmonious and professional
      final List<Color> chartColors = [
        const Color(0xFF6366F1), // Indigo
        const Color(0xFF06B6D4), // Cyan
        const Color(0xFF10B981), // Emerald
        const Color(0xFFF59E0B), // Amber
        const Color(0xFFEF4444), // Red
        const Color(0xFF8B5CF6), // Violet
        const Color(0xFFEC4899), // Pink
        const Color(0xFF14B8A6), // Teal
        const Color(0xFFF97316), // Orange
        const Color(0xFF84CC16), // Lime
      ];

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Expense Breakdown",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      "₹${total.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),

                // Pie Chart - responsive sizing
                Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final size = constraints.maxWidth;
                        final radius = size * 0.30; // 30% of available space
                        final centerSpace =
                            size * 0.10; // 10% of available space

                        return PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: centerSpace,
                            sections:
                                categoryData.entries.toList().asMap().entries.map((
                                  entry,
                                ) {
                                  final index = entry.key;
                                  final categoryEntry = entry.value;
                                  final percentage =
                                      (categoryEntry.value / total) * 100;

                                  return PieChartSectionData(
                                    value: categoryEntry.value,
                                    // title: percentage > 8 ? "${percentage.toStringAsFixed(0)}%" : "",
                                    title: "${percentage.toStringAsFixed(0)}%",
                                    color:
                                        chartColors[index % chartColors.length],
                                    radius: radius,
                                    titleStyle: TextStyle(
                                      fontSize:
                                          size * 0.035, // Responsive font size
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  );
                                }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Legend - below the chart
                Column(
                  children:
                      categoryData.entries.toList().asMap().entries.map((
                        entry,
                      ) {
                        final index = entry.key;
                        final categoryEntry = entry.value;
                        final color = chartColors[index % chartColors.length];
                        final percentage = (categoryEntry.value / total) * 100;

                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  categoryEntry.key,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "₹${categoryEntry.value.toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  Text(
                                    "${percentage.toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget recentTransactionCardWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Important: don't take infinite height
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Transaction",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(TransactionListScreen())?.then((_) => _refresh());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.green),
                      ),
                    ),
                    child: Text("View All"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Use shrinkWrap ListView without fixed height
              Obx(
                () =>
                    dashboardController.monthlyTransactionList.isNotEmpty
                        ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              dashboardController.monthlyTransactionList.length,
                          itemBuilder: (context, index) {
                            final transaction =
                                dashboardController
                                    .monthlyTransactionList[index];
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      transaction.isIncome
                                          ? Colors.green.shade100
                                          : Colors.red.shade100,
                                  child: Icon(
                                    transaction.isIncome
                                        ? Icons.arrow_downward
                                        : Icons.arrow_upward,
                                    color:
                                        transaction.isIncome
                                            ? Colors.green.shade800
                                            : Colors.red.shade800,
                                  ),
                                ),
                                title: Text(transaction.description),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(transaction.category),
                                    Text(
                                      DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(transaction.date),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "₹${transaction.amount.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color:
                                              transaction.isIncome
                                                  ? Colors.green.shade800
                                                  : Colors.red.shade800,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      transaction.isIncome
                                          ? "Income"
                                          : "Expense",
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                        : Center(child: Text("No transactions this month")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:my_pfd/helper/month_selector_controller.dart';
// import 'package:my_pfd/screens/Dashboard/controller/dashboard_controller.dart';
// import 'package:my_pfd/screens/transactionList/view/transaction_list_screen.dart';
//
// import '../../add_transaction/view/add_transaction_screen.dart';
//
// class DashboardScreen extends StatefulWidget {
//   DashboardScreen({super.key});
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   MonthSelectorController monthSelectorController = Get.put(
//     MonthSelectorController(),
//   );
//
//   DashboardController dashboardController = Get.put(DashboardController());
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.green,
//         foregroundColor: Colors.white,
//         title: Text("Finance Dashboard"),
//       ),
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.to(AddTransactionScreen());
//         },
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.green,
//         child: Icon(Icons.add),
//       ),
//
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//
//           //month year
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Card(
//                 color: Colors.white,
//                 elevation: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 20,
//                     horizontal: 20,
//                   ),
//                   child: Obx(
//                     () => Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             monthSelectorController.previousMonth();
//                             dashboardController.selectedMonthAndYear.value =
//                                 monthSelectorController.formattedMonthYear
//                                     .toString();
//
//                             print(
//                               dashboardController.selectedMonthAndYear.value,
//                             );
//                             dashboardController.parseMonthYear(
//                               dashboardController.selectedMonthAndYear.value
//                                   .toString(),
//                             );
//                           },
//                           child: const Icon(Icons.arrow_back_ios),
//                         ),
//                         Flexible(
//                           child: Text(
//                             monthSelectorController.formattedMonthYear,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             monthSelectorController.nextMonth();
//                             dashboardController.selectedMonthAndYear.value =
//                                 monthSelectorController.formattedMonthYear
//                                     .toString();
//
//                             print(
//                               dashboardController.selectedMonthAndYear.value,
//                             );
//
//                             dashboardController.parseMonthYear(
//                               dashboardController.selectedMonthAndYear.value
//                                   .toString(),
//                             );
//                           },
//                           child: const Icon(Icons.arrow_forward_ios),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             // total income and total expence
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal:  20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Expanded(
//                     child: Obx(
//                           () => Card(
//                         color: Colors.white,
//                         elevation: 2,
//                         child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.arrow_upward, color: Colors.green),
//                                     SizedBox(width: 5),
//                                     Flexible(child: Text("Total Income")),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Flexible(
//                                       child: Text(
//                                         " ₹${dashboardController.totalMonthlyIncome.value.toStringAsFixed(2)}",
//                                         style: TextStyle(
//                                           color: Colors.green,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Expanded(
//                     child: Obx(
//                           () => Card(
//                         color: Colors.white,
//                         elevation: 2,
//                         child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.arrow_downward, color: Colors.red),
//                                     SizedBox(width: 5),
//                                     Flexible(
//                                       child: Text(
//                                         "Total Expence",
//                                         style: TextStyle(
//                                           // color: Colors.red
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Flexible(
//                                       child: Text(
//                                         " ₹${dashboardController.totalMonthlyExpense.value.toStringAsFixed(2)}",
//                                         style: TextStyle(color: Colors.red),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             //net balance
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Obx(
//                     () => Card(
//                   color: Colors.white,
//                   elevation: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 20,
//                       horizontal: 20,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.trending_up, color: Colors.orange),
//                             SizedBox(width: 5),
//                             Text(
//                               "Net Balance",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//
//                         Center(
//                           child: Text(
//                             " ₹${dashboardController.netBalanceMonthly.value.toStringAsFixed(2)}",
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.orange,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             //  chart
//             Obx(() {
//               final categoryData = dashboardController.getExpenseCategoryData();
//               if (categoryData.isEmpty) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Card(
//                     elevation: 2,
//                     color: Colors.white,
//                     child: Container(
//                       padding: const EdgeInsets.all(16),
//                       child: Center(
//                         child: Text(
//                           "No expense data available",
//                           style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }
//
//               final total = categoryData.values.fold(0.0, (sum, item) => sum + item);
//
//               // Beautiful color combination - harmonious and professional
//               final List<Color> chartColors = [
//                 Color(0xFF6366F1), // Indigo
//                 Color(0xFF06B6D4), // Cyan
//                 Color(0xFF10B981), // Emerald
//                 Color(0xFFF59E0B), // Amber
//                 Color(0xFFEF4444), // Red
//                 Color(0xFF8B5CF6), // Violet
//                 Color(0xFFEC4899), // Pink
//                 Color(0xFF14B8A6), // Teal
//                 Color(0xFFF97316), // Orange
//                 Color(0xFF84CC16), // Lime
//               ];
//
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: Card(
//                   color: Colors.white,
//                   elevation: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Header
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Expense Breakdown",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.grey[800],
//                               ),
//                             ),
//                             Text(
//                               "₹${total.toStringAsFixed(2)}",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         // SizedBox(height: 20),
//
//                         // Pie Chart - responsive sizing
//                         Center(
//                           child: AspectRatio(
//                             aspectRatio: 1,
//                             child: LayoutBuilder(
//                               builder: (context, constraints) {
//                                 final size = constraints.maxWidth;
//                                 final radius = size * 0.30; // 35% of available space
//                                 final centerSpace = size * 0.10; // 25% of available space
//
//                                 return PieChart(
//                                   PieChartData(
//                                     sectionsSpace: 2,
//                                     centerSpaceRadius: centerSpace,
//                                     sections: categoryData.entries.toList().asMap().entries.map((entry) {
//                                       final index = entry.key;
//                                       final categoryEntry = entry.value;
//                                       final percentage = (categoryEntry.value / total) * 100;
//
//                                       return PieChartSectionData(
//                                         value: categoryEntry.value,
//                                         title: percentage > 8 ? "${percentage.toStringAsFixed(0)}%" : "",
//                                         color: chartColors[index % chartColors.length],
//                                         radius: radius,
//                                         titleStyle: TextStyle(
//                                           fontSize: size * 0.035, // Responsive font size
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white,
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//
//                         // SizedBox(height: 24),
//
//                         // Legend - below the chart
//                         Column(
//                           children: categoryData.entries.toList().asMap().entries.map((entry) {
//                             final index = entry.key;
//                             final categoryEntry = entry.value;
//                             final color = chartColors[index % chartColors.length];
//                             final percentage = (categoryEntry.value / total) * 100;
//
//                             return Container(
//                               margin: EdgeInsets.only(bottom: 12),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width: 16,
//                                     height: 16,
//                                     decoration: BoxDecoration(
//                                       color: color,
//                                       borderRadius: BorderRadius.circular(3),
//                                     ),
//                                   ),
//                                   SizedBox(width: 12),
//                                   Expanded(
//                                     child: Text(
//                                       categoryEntry.key,
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.grey[700],
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: 8),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         "₹${categoryEntry.value.toStringAsFixed(0)}",
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.grey[800],
//                                         ),
//                                       ),
//                                       Text(
//                                         "${percentage.toStringAsFixed(1)}%",
//                                         style: TextStyle(
//                                           fontSize: 11,
//                                           color: Colors.grey[500],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }),
//
//
//             // recent transection
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//               child: Card(
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min, // Important: don't take infinite height
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Recent Transaction",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           TextButton(onPressed: (){
//                             Get.to(TransactionListScreen());
//                           },
//                               style: TextButton.styleFrom(
//                                 foregroundColor: Colors.green,
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.green))
//                               ),
//                               child: Text("View All")),
//
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       // Use shrinkWrap ListView without fixed height
//                       Obx(
//                             () => dashboardController.monthlyTransactionList.isNotEmpty
//                             ? ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: dashboardController.monthlyTransactionList.length,
//                           itemBuilder: (context, index) {
//                             final transaction = dashboardController.monthlyTransactionList[index];
//                             return Card(
//                               elevation: 2,
//                               child: ListTile(
//                                 tileColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 leading: CircleAvatar(
//                                   backgroundColor: transaction.isIncome
//                                       ? Colors.green.shade100
//                                       : Colors.red.shade100,
//                                   child: Icon(
//                                     transaction.isIncome
//                                         ? Icons.arrow_downward
//                                         : Icons.arrow_upward,
//                                     color: transaction.isIncome
//                                         ? Colors.green.shade800
//                                         : Colors.red.shade800,
//                                   ),
//                                 ),
//                                 title: Text(transaction.description),
//                                 subtitle: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(transaction.category),
//                                     Text(
//                                       DateFormat('dd-MM-yyyy').format(
//                                         DateTime.parse(transaction.date),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 trailing: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Flexible(
//                                       child: Text(
//                                         "₹${transaction.amount.toStringAsFixed(2)}",
//                                         style: TextStyle(
//                                           color: transaction.isIncome
//                                               ? Colors.green.shade800
//                                               : Colors.red.shade800,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                     Text(
//                                       transaction.isIncome ? "Income" : "Expense",
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         )
//                             : Center(
//                           child: Text("No transactions this month"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
