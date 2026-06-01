import 'package:flock_pilot/shared/models/farm_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final List<FarmModel> farms;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.farms,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final farmsJson = json['farms'];

    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      farms: farmsJson is List
          ? farmsJson.map((f) => FarmModel.fromJson(f)).toList()
          : [],
    );
  }
}
