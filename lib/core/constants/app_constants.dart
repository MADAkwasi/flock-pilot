import 'dart:ui';

import 'package:flock_pilot/core/router/route_names.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<Map<String, dynamic>> statsData = [
  {
    "icon": FontAwesomeIcons.egg,
    "cardName": "Eggs Today",
    "statFigure": 1240,
    "rateChange": 4.8,
    "cardColor": const Color(0xFF2B7FFF),
  },
  {
    "icon": FontAwesomeIcons.truck,
    "cardName": "Deliveries",
    "statFigure": 14,
    "rateChange": 2.1,
    "cardColor": const Color(0xFF03A9F4),
  },
  {
    "icon": FontAwesomeIcons.moneyBillTrendUp,
    "cardName": "Revenue",
    "statFigure": 12500,
    "rateChange": 7.4,
    "cardColor": const Color(0xFF00C853),
  },
  {
    "icon": FontAwesomeIcons.drumstickBite,
    "cardName": "Mortality Rate",
    "statFigure": 3,
    "rateChange": -0.4,
    "cardColor": const Color(0xFF5C1A1A),
  },
];

final List<Map<String, dynamic>> actionCards = [
  {
    'actionLabel': 'Record Eggs',
    'icon': FontAwesomeIcons.egg,
    'cardColor': const Color(0xFF2B7FFF),
    // 'route': RouteNames.eggs,
  },

  {
    'actionLabel': 'Manage Deliveries',
    'icon': FontAwesomeIcons.truck,
    'cardColor': const Color(0xFF03A9F4),
    // 'route': RouteNames.deliveries,
  },

  {
    'actionLabel': 'View Revenue',
    'icon': FontAwesomeIcons.moneyBillTrendUp,
    'cardColor': const Color(0xFF00C853),
    // 'route': RouteNames.revenue,
  },

  {
    'actionLabel': 'Log Mortality',
    'icon': FontAwesomeIcons.drumstickBite,
    'cardColor': const Color(0xFF5C1A1A),
    // 'route': RouteNames.mortality,
  },
];

final List<Map<String, dynamic>> notificationsData = [
  {
    "title": "Low Feed Stock",
    "message":
        "Starter feed is running low for Batch A. Refill recommended within 2 days.",
    "time": "10 mins ago",
    "type": "warning",
    "icon": FontAwesomeIcons.wheatAwn,
  },

  {
    "title": "High Egg Production",
    "message": "Batch C exceeded today's egg production target by 12%.",
    "time": "35 mins ago",
    "type": "success",
    "icon": FontAwesomeIcons.egg,
  },

  {
    "title": "Mortality Alert",
    "message":
        "2 bird deaths recorded in Batch B during the morning inspection.",
    "time": "1 hour ago",
    "type": "danger",
    "icon": FontAwesomeIcons.drumstickBite,
  },

  {
    "title": "Vaccination Reminder",
    "message": "Batch D is scheduled for Newcastle vaccination tomorrow.",
    "time": "3 hours ago",
    "type": "info",
    "icon": FontAwesomeIcons.syringe,
  },

  {
    "title": "Delivery Completed",
    "message": "Egg shipment to Accra Market was successfully delivered.",
    "time": "5 hours ago",
    "type": "success",
    "icon": FontAwesomeIcons.truck,
  },

  {
    "title": "Water Consumption Spike",
    "message": "Batch A recorded unusually high water intake today.",
    "time": "Yesterday",
    "type": "warning",
    "icon": FontAwesomeIcons.droplet,
  },

  {
    "title": "Revenue Milestone",
    "message": "Farm revenue crossed GHS 12,000 this month.",
    "time": "Yesterday",
    "type": "success",
    "icon": FontAwesomeIcons.moneyBillTrendUp,
  },
];
