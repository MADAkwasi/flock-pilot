import 'package:flock_pilot/shared/models/expense_model.dart';
import 'package:flock_pilot/shared/models/flock_model.dart';
import 'package:flock_pilot/shared/models/inventory_item_model.dart';
import 'package:flock_pilot/shared/models/sale_model.dart';

class FarmSummaryModel {
  final String id;
  final String name;
  final String? location;
  final String? farmType;
  final bool isActive;

  FarmSummaryModel({
    required this.id,
    required this.name,
    required this.location,
    required this.farmType,
    required this.isActive,
  });

  factory FarmSummaryModel.fromJson(Map<String, dynamic> json) {
    return FarmSummaryModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      farmType: json['farmType'],
      isActive: json['isActive'] ?? true,
    );
  }
}

class FarmModel {
  final String id;
  final String name;
  final String? location;
  final String? description;
  final String ownerId;
  final bool isActive;
  final String? farmType;

  final List<FlockModel> flocks;
  final List<InventoryItemModel> inventoryItems;
  final List<ExpenseModel> expenses;
  final List<SaleModel> sales;

  FarmModel({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.isActive,
    required this.flocks,
    required this.inventoryItems,
    required this.expenses,
    required this.sales,
    this.location,
    this.description,
    this.farmType,
  });

  factory FarmModel.fromJson(Map<String, dynamic> json) {
    return FarmModel(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      isActive: json['isActive'] ?? true,
      location: json['location'],
      description: json['description'],
      farmType: json['farmType'],

      flocks: (json['flocks'] as List? ?? [])
          .map((e) => FlockModel.fromJson(e))
          .toList(),

      inventoryItems: (json['inventoryItems'] as List? ?? [])
          .map((e) => InventoryItemModel.fromJson(e))
          .toList(),

      expenses: (json['expenses'] as List? ?? [])
          .map((e) => ExpenseModel.fromJson(e))
          .toList(),

      sales: (json['sales'] as List? ?? [])
          .map((e) => SaleModel.fromJson(e))
          .toList(),
    );
  }
}
