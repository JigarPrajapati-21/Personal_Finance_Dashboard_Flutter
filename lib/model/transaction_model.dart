class TransactionModel {
  final int id;
  final double amount;
  final String description;
  final String category;
  final String date;
  final bool isIncome;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
    required this.isIncome,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'category': category,
      'date': date,
      'isIncome': isIncome ? 1 : 0,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: map['amount'],
      description: map['description'],
      category: map['category'],
      date: map['date'],
      isIncome: map['isIncome'] == 1,
    );
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, amount: $amount, description: $description, category: $category, date: $date, isIncome: $isIncome)';
  }
}
