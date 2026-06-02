class EggProductionModel {
  final String id;
  final String flockId;
  final int count;
  final int broken;
  final DateTime recordedAt;

  EggProductionModel({
    required this.id,
    required this.flockId,
    required this.count,
    required this.broken,
    required this.recordedAt,
  });

  factory EggProductionModel.fromJson(Map<String, dynamic> json) {
    return EggProductionModel(
      id: json['id'],
      flockId: json['flockId'],
      count: json['count'] ?? 0,
      broken: json['broken'] ?? 0,
      recordedAt: DateTime.parse(json['recordedAt']),
    );
  }
}
