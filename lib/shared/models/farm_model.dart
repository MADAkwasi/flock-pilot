class FarmModel {
  final String id;
  final String name;
  final String farmType;
  final bool isActive;

  FarmModel({
    required this.id,
    required this.name,
    required this.farmType,
    required this.isActive,
  });

  factory FarmModel.fromJson(Map<String, dynamic> json) {
    return FarmModel(
      id: json['id'],
      name: json['name'],
      farmType: json['farmType'],
      isActive: json['isActive'],
    );
  }
}
