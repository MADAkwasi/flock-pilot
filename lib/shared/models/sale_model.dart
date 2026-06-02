class SaleModel {
  final String id;
  final String? farmId;
  final String? flockId;
  final String type;
  final double quantity;
  final double unitPrice;
  final double totalAmount;

  SaleModel({
    required this.id,
    this.farmId,
    required this.type,
    required this.quantity,
    required this.unitPrice,
    required this.totalAmount,
    this.flockId,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['id'],
      farmId: json['farmId'],
      flockId: json['flockId'],
      type: json['type'],
      quantity: (json['quantity'] ?? 0).toDouble(),
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
    );
  }
}
