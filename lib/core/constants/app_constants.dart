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
