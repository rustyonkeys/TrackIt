import 'package:expense_tracker/models/transaction_entry.dart';
import 'package:expense_tracker/pages/homepage.dart';
import 'package:expense_tracker/pages/expenselistpage.dart';
import 'package:expense_tracker/pages/fixed_expenses_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('home shows an empty state without transactions', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Homepage(transactions: [])),
    );

    expect(find.text('\$0.00'), findsNWidgets(3));
    expect(find.text('No transactions yet. Add one to see it here.'), findsOne);
  });

  testWidgets('home calculates and displays saved transactions', (
    tester,
  ) async {
    final transactions = [
      TransactionEntry(
        amount: 125,
        isExpense: false,
        category: 'Salary',
        note: '',
        date: DateTime.now(),
        emoji: '',
      ),
      TransactionEntry(
        amount: 25,
        isExpense: true,
        category: 'Food',
        note: 'Lunch',
        date: DateTime.now(),
        emoji: '',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(home: Homepage(transactions: transactions)),
    );

    expect(find.text('\$100.00'), findsOne);
    expect(find.text('\$125.00'), findsOne);
    expect(find.text('\$25.00'), findsOne);
    expect(find.text('Lunch'), findsOne);
  });

  testWidgets('activity can switch between time filters', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: ExpenseListPage(transactions: [])),
    );

    expect(find.text('Day'), findsOne);
    expect(find.text('Month'), findsOne);
    expect(find.text('Quarter'), findsOne);
    expect(find.text('Year'), findsOne);

    await tester.tap(find.text('Quarter'));
    await tester.pumpAndSettle();

    final quarter = ((DateTime.now().month - 1) ~/ 3) + 1;
    expect(find.text('Q$quarter ${DateTime.now().year}'), findsOne);
  });

  testWidgets('fixed expenses page contains both drag sections', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: FixedExpensesPage()));

    expect(find.text('Expected Expenses'), findsOne);
    expect(find.text('This Month Expenses'), findsOne);
    expect(find.byTooltip('Add fixed expense'), findsOne);
  });
}
