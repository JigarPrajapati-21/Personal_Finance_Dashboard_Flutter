import 'package:flutter/material.dart';
import 'package:my_pfd/screens/add_transaction/view/add_transaction_screen.dart';

import '../screens/Dashboard/view/dashboard_screen.dart';
import '../screens/categories/view/categories_screen.dart';
import '../screens/transactionList/view/transaction_list_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    DashboardScreen(),
    // Center(child: Text("Dashboard", style: TextStyle(color: Colors.green, fontSize: 18))),
    TransactionListScreen(),
    // Center(child: Text("transaction", style: TextStyle(color: Colors.green, fontSize: 18))),
    AddTransactionScreen(),
    CategoriesScreen(),
    // Center(child: Text("category", style: TextStyle(color: Colors.green, fontSize: 18))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Colors.green,
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: "transaction"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "category"),
        ],
      ),
    );
  }
}
