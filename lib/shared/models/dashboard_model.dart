class DashboardModel {
  final String summary;
  final List<DashboardInsightModel> insights;
  final List<DashboardPredictionModel> predictions;
  final DashboardOverviewModel overview;

  DashboardModel({
    required this.summary,
    required this.insights,
    required this.predictions,
    required this.overview,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      summary: json['summary'] ?? '',

      insights: (json['insights'] as List? ?? [])
          .map((e) => DashboardInsightModel.fromJson(e))
          .toList(),

      predictions: (json['predictions'] as List? ?? [])
          .map((e) => DashboardPredictionModel.fromJson(e))
          .toList(),

      overview: DashboardOverviewModel.fromJson(
        json['overview'] as Map<String, dynamic>?,
      ),
    );
  }
}

class DashboardPredictionModel {
  final String id;
  final String type;
  final String severity;
  final String message;
  final double probability;
  final String horizon;
  final Map<String, dynamic>? meta;

  DashboardPredictionModel({
    required this.id,
    required this.type,
    required this.severity,
    required this.message,
    required this.probability,
    required this.horizon,
    this.meta,
  });

  factory DashboardPredictionModel.fromJson(Map<String, dynamic> json) {
    return DashboardPredictionModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      severity: json['severity'] ?? '',
      message: json['message'] ?? '',
      probability: (json['probability'] ?? 0).toDouble(),
      horizon: json['horizon'] ?? '',
      meta: json['meta'],
    );
  }
}

class DashboardInsightModel {
  final String id;
  final String type;
  final String severity;
  final String message;
  final Map<String, dynamic>? meta;

  DashboardInsightModel({
    required this.id,
    required this.type,
    required this.severity,
    required this.message,
    this.meta,
  });

  factory DashboardInsightModel.fromJson(Map<String, dynamic> json) {
    return DashboardInsightModel(
      id: json['id'],
      type: json['type'],
      severity: json['severity'],
      message: json['message'],
      meta: json['meta'],
    );
  }
}

class LowStockItemModel {
  final String id;
  final String name;

  LowStockItemModel({required this.id, required this.name});

  factory LowStockItemModel.fromJson(Map<String, dynamic> json) {
    return LowStockItemModel(id: json['id'], name: json['name']);
  }
}

class DashboardSummaryModel {
  final int totalBirds;
  final int activeFlocks;
  final double mortalityRate;

  DashboardSummaryModel({
    required this.totalBirds,
    required this.activeFlocks,
    required this.mortalityRate,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryModel(
      totalBirds: (json['totalBirds'] ?? 0),
      activeFlocks: (json['activeFlocks'] ?? 0),
      mortalityRate: (json['mortalityRate'] ?? 0).toDouble(),
    );
  }
}

class DashboardProductionModel {
  final int totalEggs;

  DashboardProductionModel({required this.totalEggs});

  factory DashboardProductionModel.fromJson(Map<String, dynamic> json) {
    return DashboardProductionModel(totalEggs: json['totalEggs']);
  }
}

class DashboardFinanceModel {
  final double totalSales;
  final double totalExpenses;
  final double profit;
  final double profitMargin;

  DashboardFinanceModel({
    required this.totalSales,
    required this.totalExpenses,
    required this.profit,
    required this.profitMargin,
  });

  factory DashboardFinanceModel.fromJson(Map<String, dynamic> json) {
    return DashboardFinanceModel(
      totalSales: (json['totalSales'] ?? 0).toDouble(),
      totalExpenses: (json['totalExpenses'] ?? 0).toDouble(),
      profit: (json['profit'] ?? 0).toDouble(),
      profitMargin: (json['profitMargin'] ?? 0).toDouble(),
    );
  }
}

class DashboardInventoryModel {
  final int totalItems;
  final List<LowStockItemModel> lowStockItems;

  DashboardInventoryModel({
    required this.totalItems,
    required this.lowStockItems,
  });

  factory DashboardInventoryModel.fromJson(Map<String, dynamic> json) {
    return DashboardInventoryModel(
      totalItems: (json['totalItems'] ?? 0),

      lowStockItems: (json['lowStockItems'] as List? ?? [])
          .map((item) => LowStockItemModel.fromJson(item))
          .toList(),
    );
  }
}

class DashboardFlockHealthModel {
  final int totalMortality;

  DashboardFlockHealthModel({required this.totalMortality});

  factory DashboardFlockHealthModel.fromJson(Map<String, dynamic> json) {
    return DashboardFlockHealthModel(totalMortality: json['totalMortality']);
  }
}

class DashboardOverviewModel {
  final DashboardSummaryModel summary;
  final DashboardProductionModel production;
  final DashboardFinanceModel finance;
  final DashboardInventoryModel inventory;
  final DashboardFlockHealthModel flockHealth;
  final List<String> risks;

  DashboardOverviewModel({
    required this.summary,
    required this.production,
    required this.finance,
    required this.inventory,
    required this.flockHealth,
    required this.risks,
  });

  factory DashboardOverviewModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};

    return DashboardOverviewModel(
      summary: DashboardSummaryModel.fromJson(
        data['summary'] as Map<String, dynamic>? ?? {},
      ),
      production: DashboardProductionModel.fromJson(
        data['production'] as Map<String, dynamic>? ?? {},
      ),
      finance: DashboardFinanceModel.fromJson(
        data['finance'] as Map<String, dynamic>? ?? {},
      ),
      inventory: DashboardInventoryModel.fromJson(
        data['inventory'] as Map<String, dynamic>? ?? {},
      ),
      flockHealth: DashboardFlockHealthModel.fromJson(
        data['flockHealth'] as Map<String, dynamic>? ?? {},
      ),
      risks: List<String>.from(data['risks'] ?? []),
    );
  }
}
