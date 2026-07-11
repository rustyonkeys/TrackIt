import 'dart:convert';

import 'package:expense_tracker/pages/addingpage.dart';
import 'package:expense_tracker/pages/analyticspage.dart';
import 'package:expense_tracker/pages/expenselistpage.dart';
import 'package:expense_tracker/pages/fixed_expenses_page.dart';
import 'package:expense_tracker/pages/homepage.dart';
import 'package:expense_tracker/pages/accountpage.dart';
import 'package:expense_tracker/models/transaction_entry.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  static const _transactionsKey = 'transactions';
  int selectedIndex = 0;
  final List<TransactionEntry> transactions = [];
  static const _ink = Color(0xFF17151D);
  static const _muted = Color(0xFF9A94A3);
  static const _accent = Color(0xFFD9FF3F);

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _addTransaction(TransactionEntry transaction) {
    setState(() {
      transactions.insert(0, transaction);
      selectedIndex = 0;
    });
    _saveTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encodedTransactions = prefs.getString(_transactionsKey);
      if (encodedTransactions == null || encodedTransactions.isEmpty) return;

      final decoded = jsonDecode(encodedTransactions);
      if (decoded is! List) return;

      final storedTransactions =
          decoded
              .whereType<Map<String, dynamic>>()
              .map(TransactionEntry.fromJson)
              .toList();

      if (!mounted) return;
      setState(() {
        transactions
          ..clear()
          ..addAll(storedTransactions);
      });
    } catch (_) {
      // Ignore corrupt or unavailable local storage and keep the app usable.
    }
  }

  Future<void> _saveTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encodedTransactions = jsonEncode(
        transactions.map((transaction) => transaction.toJson()).toList(),
      );
      await prefs.setString(_transactionsKey, encodedTransactions);
    } catch (_) {
      // Local persistence is best-effort; the in-memory state remains current.
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      Homepage(transactions: transactions),
      ExpenseListPage(transactions: transactions),
      const FixedExpensesPage(),
      AddExpense(onSave: _addTransaction),
      const AnalyticsPage(),
      const Account(),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Main page content
          pages[selectedIndex],

          // Floating navbar
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: _ink.withValues(alpha: 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home, 0),
                  _buildNavItem(Icons.list_alt, 1),
                  _buildNavItem(Icons.event_repeat, 2),
                  _buildNavItem(Icons.add, 3),
                  _buildNavItem(Icons.analytics_outlined, 4),
                  _buildNavItem(Icons.person, 5),
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
        duration: const Duration(milliseconds: 250),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isSelected ? _ink : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 24,
          color: isSelected ? _accent : _muted,
        ),
      ),
    );
  }
}
