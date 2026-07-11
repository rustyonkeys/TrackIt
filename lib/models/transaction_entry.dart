class TransactionEntry {
  const TransactionEntry({
    required this.amount,
    required this.isExpense,
    required this.category,
    required this.note,
    required this.date,
    required this.emoji,
  });

  final double amount;
  final bool isExpense;
  final String category;
  final String note;
  final DateTime date;
  final String emoji;

  double get signedAmount => isExpense ? -amount : amount;

  factory TransactionEntry.fromJson(Map<String, dynamic> json) {
    return TransactionEntry(
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      isExpense: json['isExpense'] as bool? ?? true,
      category: json['category'] as String? ?? '',
      note: json['note'] as String? ?? '',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      emoji: json['emoji'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'isExpense': isExpense,
      'category': category,
      'note': note,
      'date': date.toIso8601String(),
      'emoji': emoji,
    };
  }

  String get title {
    if (note.isNotEmpty) return note;
    if (category.isNotEmpty) return category;
    return isExpense ? 'Expense' : 'Income';
  }
}
