class FlockModel {
  final String id;
  final String name;
  final String? breed;
  final String flockType;
  final int currentCount;
  final int initialCount;
  final String? source;
  final String status;
  final DateTime startDate;

  final int eggsLaid;
  final double feedConsumed;

  FlockModel({
    required this.id,
    required this.name,
    required this.flockType,
    required this.currentCount,
    required this.initialCount,
    required this.status,
    required this.eggsLaid,
    required this.feedConsumed,
    required this.startDate,
    this.breed,
    this.source,
  });

  factory FlockModel.fromJson(Map<String, dynamic> json) {
    return FlockModel(
      id: json['id'],
      name: json['name'],
      breed: json['breed'],
      flockType: json['flockType'],
      currentCount: json['currentCount'] ?? 0,
      initialCount: json['initialCount'] ?? 0,
      source: json['source'],
      status: json['status'],
      startDate: DateTime.parse(json['startDate']),

      eggsLaid: json['eggsLaid'] ?? 0,
      feedConsumed: (json['feedConsumed'] ?? 0).toDouble(),
    );
  }
}
