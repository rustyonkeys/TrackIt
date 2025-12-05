import 'package:expense_tracker/pages/addingpage.dart';
import 'package:expense_tracker/pages/analyticspage.dart';
import 'package:expense_tracker/pages/expenselistpage.dart';
import 'package:expense_tracker/pages/homepage.dart';
import 'package:expense_tracker/pages/accountpage.dart';
import 'package:flutter/material.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    Homepage(),
    ExpenseListPage(),
    AddExpense(),
    AnalyticsPage(),
    Account()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Main page content
          pages[selectedIndex],

          // Floating navbar
          Positioned(
            left: 45,
            right: 45,
            bottom: 20,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home, 0),
                  _buildNavItem(Icons.list_alt, 1),
                  _buildNavItem(Icons.add, 2),
                  _buildNavItem(Icons.analytics_outlined, 3),
                  _buildNavItem(Icons.person, 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        // decoration: BoxDecoration(
        //   color: isSelected ? Colors.blueGrey.withOpacity(0.15) : Colors.transparent,
        //   borderRadius: BorderRadius.circular(20),
        // ),
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? Colors.blueGrey : Colors.grey,
        ),
      ),
    );
  }
}
