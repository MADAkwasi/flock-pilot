import 'package:flock_pilot/shared/models/farm_model.dart';

class FarmState {
  final bool isLoading;
  final FarmModel? farm;
  final String? error;

  FarmState({this.isLoading = false, this.farm, this.error});

  FarmState copyWith({bool? isLoading, FarmModel? farm, String? error}) {
    return FarmState(
      isLoading: isLoading ?? this.isLoading,
      farm: farm ?? this.farm,
      error: error,
    );
  }
}
