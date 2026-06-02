class FeedLogModel {
  final String id;
  final String flockId;
  final String inventoryItemId;
  final double quantityKg;
  final String? notes;
  final DateTime recordedAt;

  FeedLogModel({
    required this.id,
    required this.flockId,
    required this.inventoryItemId,
    required this.quantityKg,
    required this.recordedAt,
    this.notes,
  });

  factory FeedLogModel.fromJson(Map<String, dynamic> json) {
    return FeedLogModel(
      id: json['id'],
      flockId: json['flockId'],
      inventoryItemId: json['inventoryItemId'],
      quantityKg: (json['quantityKg'] ?? 0).toDouble(),
      notes: json['notes'],
      recordedAt: DateTime.parse(json['recordedAt']),
    );
  }
}
