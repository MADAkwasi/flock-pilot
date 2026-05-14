import 'dart:ui';

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
    "icon": FontAwesomeIcons.drumstickBite,
    "cardName": "Mortality Rate",
    "statFigure": 3,
    "rateChange": -0.4,
    "cardColor": const Color(0xFF5C1A1A),
  },
  {
    "icon": FontAwesomeIcons.moneyBillTrendUp,
    "cardName": "Revenue",
    "statFigure": 12500,
    "rateChange": 7.4,
    "cardColor": const Color(0xFF00C853),
  },
  {
    "icon": FontAwesomeIcons.wheatAwn,
    "cardName": "Feed Consumed",
    "statFigure": 320,
    "rateChange": -1.2,
    "cardColor": const Color(0xFF7F4FFF),
  },
];
