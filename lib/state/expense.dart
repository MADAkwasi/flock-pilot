class ExpenseState {
  final bool isLoading;
  final String? error;

  ExpenseState({this.isLoading = false, this.error});

  ExpenseState copyWith({bool? isLoading, String? error}) {
    return ExpenseState(isLoading: isLoading ?? this.isLoading, error: error);
  }
}
