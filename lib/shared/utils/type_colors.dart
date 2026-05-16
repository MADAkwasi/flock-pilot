import 'package:flutter/material.dart';

Color statusColor(String status) {
  switch (status.toLowerCase()) {
    case 'healthy' || 'success' || 'active':
      return Colors.green;
    case 'warning' || 'monitoring':
      return Colors.orange;
    case 'critical':
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
