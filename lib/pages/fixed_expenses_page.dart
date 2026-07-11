import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FixedExpense {
  const FixedExpense({required this.name, required this.amount});

  final String name;
  final double amount;

  factory FixedExpense.fromJson(Map<String, dynamic> json) {
    return FixedExpense(
      name: json['name'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'amount': amount};
  }
}

class FixedExpensesPage extends StatefulWidget {
  const FixedExpensesPage({super.key});

  @override
  State<FixedExpensesPage> createState() => _FixedExpensesPageState();
}

class _FixedExpensesPageState extends State<FixedExpensesPage> {
  static const _expectedExpensesKey = 'fixed_expected_expenses';
  static const _thisMonthExpensesKey = 'fixed_this_month_expenses';
  static const _background = Color(0xFFF7F2F8);
  static const _ink = Color(0xFF17151D);
  static const _muted = Color(0xFF7D7488);
  static const _surface = Color(0xFFFFFFFF);
  static const _stroke = Color(0xFFE7DFEA);
  static const _accent = Color(0xFFD9FF3F);
  final List<FixedExpense> expectedExpenses = [];
  final List<FixedExpense> thisMonthExpenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  void _moveExpense(FixedExpense expense, {required bool toExpected}) {
    setState(() {
      expectedExpenses.remove(expense);
      thisMonthExpenses.remove(expense);
      (toExpected ? expectedExpenses : thisMonthExpenses).add(expense);
    });
    _saveExpenses();
  }

  double _total(List<FixedExpense> expenses) {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  Future<void> _addExpense() async {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    final expense = await showDialog<FixedExpense>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text('Add fixed expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  fillColor: _background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: _stroke),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: _stroke),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$',
                  filled: true,
                  fillColor: _background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: _stroke),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: _stroke),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: _muted),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final name = nameController.text.trim();
                final amount = double.tryParse(amountController.text);
                if (name.isEmpty || amount == null || amount <= 0) return;

                Navigator.pop(
                  context,
                  FixedExpense(name: name, amount: amount),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: _ink,
                foregroundColor: _accent,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    nameController.dispose();
    amountController.dispose();

    if (expense != null) {
      setState(() => expectedExpenses.add(expense));
      _saveExpenses();
    }
  }

  Future<void> _loadExpenses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final expected = _decodeExpenses(prefs.getString(_expectedExpensesKey));
      final thisMonth = _decodeExpenses(prefs.getString(_thisMonthExpensesKey));

      if (!mounted) return;
      setState(() {
        expectedExpenses
          ..clear()
          ..addAll(expected);
        thisMonthExpenses
          ..clear()
          ..addAll(thisMonth);
      });
    } catch (_) {
      // Ignore corrupt or unavailable local storage and keep the app usable.
    }
  }

  Future<void> _saveExpenses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _expectedExpensesKey,
        jsonEncode(expectedExpenses.map((expense) => expense.toJson()).toList()),
      );
      await prefs.setString(
        _thisMonthExpensesKey,
        jsonEncode(thisMonthExpenses.map((expense) => expense.toJson()).toList()),
      );
    } catch (_) {
      // Local persistence is best-effort; the in-memory state remains current.
    }
  }

  List<FixedExpense> _decodeExpenses(String? encodedExpenses) {
    if (encodedExpenses == null || encodedExpenses.isEmpty) return [];
    final decoded = jsonDecode(encodedExpenses);
    if (decoded is! List) return [];

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(FixedExpense.fromJson)
        .where((expense) => expense.name.isNotEmpty && expense.amount > 0)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Fixed Expenses',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  IconButton(
                    onPressed: _addExpense,
                    icon: const Icon(Icons.add),
                    tooltip: 'Add fixed expense',
                    style: IconButton.styleFrom(
                      backgroundColor: _ink,
                      foregroundColor: _accent,
                      fixedSize: const Size(46, 46),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Long press a bill card and drag it between sections.',
                style: TextStyle(color: _muted, fontSize: 14),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: _ExpenseSection(
                  title: 'Expected',
                  emptyMessage: 'Add an expense or drag one here.',
                  icon: Icons.event_note,
                  expenses: expectedExpenses,
                  total: _total(expectedExpenses),
                  onAccept: (expense) {
                    _moveExpense(expense, toExpected: true);
                  },
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: _ExpenseSection(
                  title: 'This Month',
                  emptyMessage: 'Drag completed expenses here.',
                  icon: Icons.check_circle_outline,
                  expenses: thisMonthExpenses,
                  total: _total(thisMonthExpenses),
                  onAccept: (expense) {
                    _moveExpense(expense, toExpected: false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpenseSection extends StatelessWidget {
  const _ExpenseSection({
    required this.title,
    required this.emptyMessage,
    required this.icon,
    required this.expenses,
    required this.total,
    required this.onAccept,
  });

  final String title;
  final String emptyMessage;
  final IconData icon;
  final List<FixedExpense> expenses;
  final double total;
  final ValueChanged<FixedExpense> onAccept;

  @override
  Widget build(BuildContext context) {
    return DragTarget<FixedExpense>(
      onAcceptWithDetails: (details) => onAccept(details.data),
      builder: (context, candidateData, rejectedData) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                candidateData.isEmpty
                    ? _FixedExpensesPageState._surface
                    : _FixedExpensesPageState._accent.withValues(alpha: 0.26),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color:
                  candidateData.isEmpty
                      ? _FixedExpensesPageState._stroke
                      : _FixedExpensesPageState._ink,
            ),
            boxShadow: [
              BoxShadow(
                color: _FixedExpensesPageState._ink.withValues(alpha: 0.05),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: _FixedExpensesPageState._ink,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: _FixedExpensesPageState._accent,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '$title Expenses',
                      style: const TextStyle(
                        color: _FixedExpensesPageState._ink,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: _FixedExpensesPageState._ink,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${expenses.length} item${expenses.length == 1 ? '' : 's'}',
                style: const TextStyle(
                  color: _FixedExpensesPageState._muted,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child:
                    expenses.isEmpty
                        ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: _FixedExpensesPageState._background,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _FixedExpensesPageState._stroke,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              emptyMessage,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: _FixedExpensesPageState._muted,
                              ),
                            ),
                          ),
                        )
                        : ListView.builder(
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenses[index];
                            final card = _ExpenseCard(expense: expense);
                            return LongPressDraggable<FixedExpense>(
                              data: expense,
                              feedback: Material(
                                color: Colors.transparent,
                                child: SizedBox(width: 280, child: card),
                              ),
                              childWhenDragging: Opacity(
                                opacity: 0.3,
                                child: card,
                              ),
                              child: card,
                            );
                          },
                        ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ExpenseCard extends StatelessWidget {
  const _ExpenseCard({required this.expense});

  final FixedExpense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _FixedExpensesPageState._background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _FixedExpensesPageState._stroke),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.drag_indicator,
            color: _FixedExpensesPageState._muted,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              expense.name,
              style: const TextStyle(
                color: _FixedExpensesPageState._ink,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            '\$${expense.amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: _FixedExpensesPageState._ink,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
