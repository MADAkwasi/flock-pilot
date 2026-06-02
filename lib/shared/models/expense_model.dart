class ExpenseModel {
  final String id;
  final String? farmId;
  final String? flockId;
  final String type;
  final String category;
  final double amount;
  final String? description;

  ExpenseModel({
    required this.id,
    this.farmId,
    required this.type,
    required this.category,
    required this.amount,
    this.flockId,
    this.description,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      farmId: json['farmId'],
      flockId: json['flockId'],
      type: json['type'],
      category: json['category'],
      amount: (json['amount'] ?? 0).toDouble(),
      description: json['description'],
    );
  }
}
