import 'package:flutter/material.dart';

Color statusColor(String status) {
  switch (status.toLowerCase()) {
    case 'healthy' || 'success' || 'active' || "in stock":
      return Colors.green;
    case 'warning' || 'monitoring' || 'low stock':
      return Colors.orange;
    case 'critical' || 'out of stock':
      return Colors.red;
    case 'info':
      return Colors.blue;
    default:
      return Colors.blueGrey;
  }
}

Color typeColor(String type) {
  return type == 'layer' ? Colors.blue : Colors.deepOrange;
}
