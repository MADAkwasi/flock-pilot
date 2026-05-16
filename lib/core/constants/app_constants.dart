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
    "icon": FontAwesomeIcons.skull,
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
    'route': RouteNames.recordEggs,
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
    'icon': FontAwesomeIcons.skull,
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

final List<Map<String, dynamic>> batchData = [
  {
    "batchId": "B001",
    "batchName": "Layer Batch A",
    "type": 'layer',
    "status": "Active",
    "birds": 120,
    "ageWeeks": 12,
    "feedPerDay": 18.5,
    "eggsPerDay": 95,
    "mortality": 2,
    "healthScore": 92,
    "startDate": "2025-10-01",
  },
  {
    "batchId": "B002",
    "batchName": "Broiler Batch B",
    "type": 'broiler',
    "status": "Active",
    "birds": 80,
    "ageWeeks": 6,
    "feedPerDay": 14.2,
    "eggsPerDay": 0,
    "mortality": 1,
    "healthScore": 88,
    "startDate": "2025-11-10",
  },
  {
    "batchId": "B003",
    "batchName": "Layer Batch C",
    "type": 'layer',
    "status": "Monitoring",
    "birds": 150,
    "ageWeeks": 18,
    "feedPerDay": 22.0,
    "eggsPerDay": 110,
    "mortality": 3,
    "healthScore": 85,
    "startDate": "2025-08-15",
  },
  {
    "batchId": "B004",
    "batchName": "Starter Batch D",
    "type": 'broiler',
    "status": "Active",
    "birds": 200,
    "ageWeeks": 4,
    "feedPerDay": 16.8,
    "eggsPerDay": 0,
    "mortality": 0,
    "healthScore": 96,
    "startDate": "2025-12-01",
  },
  {
    "batchId": "B005",
    "batchName": "Layer Batch E",
    "type": 'layer',
    "status": "Critical",
    "birds": 90,
    "ageWeeks": 20,
    "feedPerDay": 20.1,
    "eggsPerDay": 70,
    "mortality": 6,
    "healthScore": 60,
    "startDate": "2025-07-20",
  },
  {
    "batchId": "B006",
    "batchName": "Broiler Batch F",
    "type": 'broiler',
    "status": "Active",
    "birds": 110,
    "ageWeeks": 8,
    "feedPerDay": 17.3,
    "eggsPerDay": 0,
    "mortality": 1,
    "healthScore": 90,
    "startDate": "2025-11-25",
  },
];

final List<Map<String, dynamic>> feedInventory = [
  {
    'feedName': 'Starter Mash',
    'batch': 'Broiler Batch B',
    'remainingKg': 240,
    'usagePerDay': 48,
    'stockPercentage': 24,
  },
  {
    'feedName': 'Layer Concentrate',
    'batch': 'Layer Batch A',
    'remainingKg': 760,
    'usagePerDay': 62,
    'stockPercentage': 78,
  },
  {
    'feedName': 'Grower Feed',
    'batch': 'Starter Batch D',
    'remainingKg': 530,
    'usagePerDay': 38,
    'stockPercentage': 54,
  },
];

final List<Map<String, dynamic>> feedActivities = [
  {
    'title': 'Added Starter Mash stock',
    'time': '10 mins ago',
    'amount': '+120kg',
  },
  {
    'title': 'Feed allocated to Layer Batch A',
    'time': '1 hour ago',
    'amount': '-48kg',
  },
  {
    'title': 'Daily feed usage logged',
    'time': 'Today • 6:30 AM',
    'amount': '-180kg',
  },
];

final List<Map<String, dynamic>> settingsOptions = [
  {
    'icon': FontAwesomeIcons.user,
    'title': 'Account',
    'subtitle': 'Manage your profile details',
  },
  {
    'icon': FontAwesomeIcons.bell,
    'title': 'Notifications',
    'subtitle': 'Alerts & reminders',
  },
  {
    'icon': FontAwesomeIcons.palette,
    'title': 'Appearance',
    'subtitle': 'Theme & display settings',
  },
  {
    'icon': FontAwesomeIcons.shield,
    'title': 'Privacy & Security',
    'subtitle': 'Password and security options',
  },
  {
    'icon': FontAwesomeIcons.circleInfo,
    'title': 'About FlockPilot',
    'subtitle': 'App version & info',
  },
];

final List<Map<String, dynamic>> batchQuickActions = [
  {
    "icon": FontAwesomeIcons.egg,
    "label": 'Record Eggs',
    "color": const Color(0xFF2B7FFF),
    "route": RouteNames.recordEggs,
  },
  {
    "icon": FontAwesomeIcons.wheatAwn,
    "label": 'Add Feed Record',
    "color": const Color(0xFF00C853),
  },
  {
    "icon": FontAwesomeIcons.syringe,
    "label": 'Schedule Vaccination',
    "color": const Color(0xFFFF9800),
  },
  {
    "icon": FontAwesomeIcons.skull,
    "label": 'Record Mortality',
    "color": const Color(0xFF8B1E1E),
  },
];
