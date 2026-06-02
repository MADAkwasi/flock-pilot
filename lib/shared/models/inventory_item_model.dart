class InventoryItemModel {
  final String id;
  final String? farmId;
  final String name;
  final String category;
  final String unit;
  final double? reorderLevel;
  final double? costPerUnit;

  InventoryItemModel({
    required this.id,
    this.farmId,
    required this.name,
    required this.category,
    required this.unit,
    this.reorderLevel,
    this.costPerUnit,
  });

  factory InventoryItemModel.fromJson(Map<String, dynamic> json) {
    return InventoryItemModel(
      id: json['id'],
      farmId: json['farmId'],
      name: json['name'],
      category: json['category'],
      unit: json['unit'],
      reorderLevel: (json['reorderLevel'] as num?)?.toDouble(),
      costPerUnit: (json['costPerUnit'] as num?)?.toDouble(),
    );
  }
}
