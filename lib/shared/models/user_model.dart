import 'package:flock_pilot/shared/models/farm_model.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String role;
  final List<FarmSummaryModel> farms;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.farms,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      farms: (json['farms'] as List? ?? [])
          .map((e) => FarmSummaryModel.fromJson(e))
          .toList(),
    );
  }
}
