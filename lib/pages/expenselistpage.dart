import 'package:expense_tracker/models/transaction_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum ActivityPeriod { day, month, quarter, year }

class ExpenseListPage extends StatefulWidget {
  const ExpenseListPage({super.key, required this.transactions});

  final List<TransactionEntry> transactions;

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  ActivityPeriod selectedPeriod = ActivityPeriod.month;
  DateTime referenceDate = DateTime.now();

  static const _background = Color(0xFFF7F2F8);
  static const _ink = Color(0xFF17151D);
  static const _muted = Color(0xFF7D7488);
  static const _surface = Color(0xFFFFFFFF);
  static const _stroke = Color(0xFFE7DFEA);
  static const _income = Color(0xFF1F8A5B);
  static const _expense = Color(0xFFB84A62);

  List<TransactionEntry> get filteredTransactions {
    return widget.transactions.where((transaction) {
      final date = transaction.date;
      switch (selectedPeriod) {
        case ActivityPeriod.day:
          return date.year == referenceDate.year &&
              date.month == referenceDate.month &&
              date.day == referenceDate.day;
        case ActivityPeriod.month:
          return date.year == referenceDate.year &&
              date.month == referenceDate.month;
        case ActivityPeriod.quarter:
          return date.year == referenceDate.year &&
              _quarter(date) == _quarter(referenceDate);
        case ActivityPeriod.year:
          return date.year == referenceDate.year;
      }
    }).toList();
  }

  int _quarter(DateTime date) => ((date.month - 1) ~/ 3) + 1;

  String get periodLabel {
    switch (selectedPeriod) {
      case ActivityPeriod.day:
        return DateFormat.yMMMd().format(referenceDate);
      case ActivityPeriod.month:
        return DateFormat.yMMMM().format(referenceDate);
      case ActivityPeriod.quarter:
        return 'Q${_quarter(referenceDate)} ${referenceDate.year}';
      case ActivityPeriod.year:
        return referenceDate.year.toString();
    }
  }

  void _changePeriod(int direction) {
    setState(() {
      switch (selectedPeriod) {
        case ActivityPeriod.day:
          referenceDate = referenceDate.add(Duration(days: direction));
          break;
        case ActivityPeriod.month:
          referenceDate = DateTime(
            referenceDate.year,
            referenceDate.month + direction,
          );
          break;
        case ActivityPeriod.quarter:
          referenceDate = DateTime(
            referenceDate.year,
            referenceDate.month + (direction * 3),
          );
          break;
        case ActivityPeriod.year:
          referenceDate = DateTime(referenceDate.year + direction);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleTransactions = filteredTransactions;

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Activity',
                style: TextStyle(
                  color: _ink,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${visibleTransactions.length} transaction${visibleTransactions.length == 1 ? '' : 's'} in this period',
                style: const TextStyle(color: _muted, fontSize: 14),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SegmentedButton<ActivityPeriod>(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return _ink;
                      }
                      return _surface;
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return _ink;
                    }),
                    side: WidgetStateProperty.all(
                      const BorderSide(color: _stroke),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                  ),
                  segments: const [
                    ButtonSegment(
                      value: ActivityPeriod.day,
                      label: Text('Day'),
                    ),
                    ButtonSegment(
                      value: ActivityPeriod.month,
                      label: Text('Month'),
                    ),
                    ButtonSegment(
                      value: ActivityPeriod.quarter,
                      label: Text('Quarter'),
                    ),
                    ButtonSegment(
                      value: ActivityPeriod.year,
                      label: Text('Year'),
                    ),
                  ],
                  selected: {selectedPeriod},
                  showSelectedIcon: false,
                  onSelectionChanged: (selection) {
                    setState(() {
                      selectedPeriod = selection.first;
                      referenceDate = DateTime.now();
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: _surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: _stroke),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => _changePeriod(-1),
                      icon: const Icon(Icons.chevron_left),
                      color: _ink,
                    ),
                    Text(
                      periodLabel,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _changePeriod(1),
                      icon: const Icon(Icons.chevron_right),
                      color: _ink,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child:
                    visibleTransactions.isEmpty
                        ? Center(
                          child: Text(
                            'No transactions for $periodLabel.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: _muted),
                          ),
                        )
                        : ListView.builder(
                          itemCount: visibleTransactions.length,
                          itemBuilder: (context, index) {
                            final transaction = visibleTransactions[index];
                            final type =
                                transaction.isExpense ? 'Expense' : 'Income';
                            final accent =
                                transaction.isExpense ? _expense : _income;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: _surface,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: _ink.withValues(alpha: 0.05),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: _ink.withValues(alpha: 0.05),
                                    blurRadius: 16,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: accent.withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      transaction.isExpense
                                          ? Icons.remove
                                          : Icons.add,
                                      color: accent,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transaction.title,
                                          style: const TextStyle(
                                            color: _ink,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${transaction.category.isEmpty ? type : transaction.category}'
                                          ' - ${DateFormat.yMMMd().format(transaction.date)}',
                                          style: const TextStyle(
                                            color: _muted,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${transaction.isExpense ? '-' : '+'}'
                                    '\$${transaction.amount.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: transaction.isExpense
                                          ? _ink
                                          : _income,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            );
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
