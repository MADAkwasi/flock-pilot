import 'package:flock_pilot/shared/models/user_model.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final UserModel? user;

  AuthState({this.isLoading = false, this.isAuthenticated = false, this.user});

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    UserModel? user,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
    );
  }
}
