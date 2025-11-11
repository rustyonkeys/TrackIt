import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ExpenseListPage()));

class ExpenseItem {
  final String name;
  final double amount;

  ExpenseItem(this.name, this.amount);
}

class ExpenseListPage extends StatefulWidget {
  const ExpenseListPage({super.key});

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  List<ExpenseItem> expectedExpenses = [
    ExpenseItem("Rent", 1000),
    ExpenseItem("Groceries", 300),
  ];

  List<ExpenseItem> thisMonthExpenses = [
    ExpenseItem("Gym", 50),
    ExpenseItem("Dining", 120),
    ExpenseItem("Movie", 40),
  ];

  void moveItem(ExpenseItem item, bool toExpected) {
    setState(() {
      if (toExpected) {
        if (!expectedExpenses.contains(item)) {
          thisMonthExpenses.remove(item);
          expectedExpenses.add(item);
        }
      } else {
        if (!thisMonthExpenses.contains(item)) {
          expectedExpenses.remove(item);
          thisMonthExpenses.add(item);
        }
      }
    });
  }

  double getTotal(List<ExpenseItem> list) =>
      list.fold(0, (sum, item) => sum + item.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text("You Activity",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
            /// Expected Expenses (Top Row)
            Expanded(
              child: DragTarget<ExpenseItem>(
                onAccept: (item) => moveItem(item, true),
                builder: (context, candidateData, rejectedData) {
                  return _buildExpenseList(
                    title: "Expected",
                    expenses: expectedExpenses,
                    onDrag: (item) => moveItem(item, false),
                  );
                },
              ),
            ),

            const Divider(height: 1, color: Colors.grey),

            /// This Month's Expenses (Bottom Row)
            Expanded(
              child: DragTarget<ExpenseItem>(
                onAccept: (item) => moveItem(item, false),
                builder: (context, candidateData, rejectedData) {
                  return _buildExpenseList(
                    title: "This Month",
                    expenses: thisMonthExpenses,
                    onDrag: (item) => moveItem(item, true),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseList({
    required String title,
    required List<ExpenseItem> expenses,
    required Function(ExpenseItem) onDrag,
  }) {
    double total = getTotal(expenses);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title Expenses",
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        Text(
          "Total: \$${total.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final item = expenses[index];
              return Draggable<ExpenseItem>(
                data: item,
                feedback: _expenseCard(item, isDragging: true),
                childWhenDragging:
                Opacity(opacity: 0.3, child: _expenseCard(item)),
                child: _expenseCard(item),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _expenseCard(ExpenseItem item, {bool isDragging = false}) {
    return Card(
      elevation: isDragging ? 8 : 2,
      color: isDragging ? Colors.amber.shade100 : Colors.white,
      child: ListTile(
        title: Text(item.name),
        trailing: Text("\$${item.amount.toStringAsFixed(2)}"),
        dense: true,
      ),
    );
  }
}
