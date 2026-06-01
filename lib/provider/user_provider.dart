import 'package:flock_pilot/provider/auth_provider.dart';
import 'package:flock_pilot/shared/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authProvider).user;
});
