class ExpenseModel {
  final String id;
  final String? farmId;
  final String? flockId;
  final String? inventoryItemId;
  final String type;
  final String category;
  final double amount;
  final String? description;
  final DateTime createdAt;

  ExpenseModel({
    required this.id,
    this.farmId,
    this.inventoryItemId,
    required this.type,
    required this.category,
    required this.amount,
    this.flockId,
    this.description,
    required this.createdAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      farmId: json['farmId'],
      flockId: json['flockId'],
      inventoryItemId: json['inventoryItemId'],
      type: json['type'],
      category: json['category'],
      amount: (json['amount'] ?? 0).toDouble(),
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
