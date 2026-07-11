import 'package:expense_tracker/models/transaction_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key, required this.transactions});

  final List<TransactionEntry> transactions;

  static const _background = Color(0xFFF7F2F8);
  static const _ink = Color(0xFF17151D);
  static const _muted = Color(0xFF7D7488);
  static const _surface = Color(0xFFFFFFFF);
  static const _accent = Color(0xFFD9FF3F);
  static const _income = Color(0xFF1F8A5B);
  static const _expense = Color(0xFFB84A62);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthlyTransactions = transactions.where((transaction) {
      return transaction.date.year == now.year &&
          transaction.date.month == now.month;
    });
    final monthlyIncome = monthlyTransactions
        .where((transaction) => !transaction.isExpense)
        .fold<double>(0, (sum, transaction) => sum + transaction.amount);
    final monthlyExpense = monthlyTransactions
        .where((transaction) => transaction.isExpense)
        .fold<double>(0, (sum, transaction) => sum + transaction.amount);
    final totalBalance = transactions.fold<double>(
      0,
      (sum, transaction) => sum + transaction.signedAmount,
    );
    final recentTransactions = transactions.take(5).toList();

    return Scaffold(
      backgroundColor: _background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TrackIt',
                        style: TextStyle(
                          color: _muted,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Welcome back',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${transactions.length} saved transaction${transactions.length == 1 ? '' : 's'}',
                        style: const TextStyle(color: _muted, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: _ink,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: _ink.withValues(alpha: 0.18),
                          blurRadius: 28,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Balance',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${totalBalance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 42,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Expanded(
                              child: _BalanceItem(
                                label: 'Income',
                                amount: monthlyIncome,
                                icon: Icons.arrow_downward,
                                color: _accent,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _BalanceItem(
                                label: 'Expense',
                                amount: monthlyExpense,
                                icon: Icons.arrow_upward,
                                color: const Color(0xFFFFB3C1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Transactions',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _surface,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _ink.withValues(alpha: 0.08),
                          ),
                        ),
                        child: const Icon(
                          Icons.more_horiz,
                          color: _muted,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (recentTransactions.isEmpty)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Center(
                      child: Text(
                        'No transactions yet. Add one to see it here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _muted, fontSize: 15),
                      ),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _TransactionTile(
                      transaction: recentTransactions[index],
                    ),
                    childCount: recentTransactions.length,
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceItem extends StatelessWidget {
  const _BalanceItem({
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
  });

  final String label;
  final double amount;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.68),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction});

  final TransactionEntry transaction;

  @override
  Widget build(BuildContext context) {
    final isIncome = !transaction.isExpense;
    final accent =
        isIncome ? Homepage._income : Homepage._expense;
    final amountColor =
        isIncome ? Homepage._income : Homepage._ink;

    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Homepage._surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Homepage._ink.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Homepage._ink.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child:
                transaction.emoji.isEmpty
                    ? Icon(
                      isIncome ? Icons.add : Icons.receipt_long,
                      color: accent,
                    )
                    : Center(
                      child: Text(
                        transaction.emoji,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Homepage._ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.category.isEmpty
                      ? (isIncome ? 'Income' : 'Expense')
                      : transaction.category,
                  style: const TextStyle(fontSize: 13, color: Homepage._muted),
                ),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : '-'}'
            '\$${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}
