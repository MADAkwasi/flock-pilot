import 'package:flock_pilot/data/ai_assistant_repository.dart';
import 'package:flock_pilot/shared/models/ai_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final aiChatRepositoryProvider = Provider<AiChatRepository>((ref) {
  throw UnimplementedError(
    'AiChatRepository must be overridden in main provider scope',
  );
});

final aiChatProvider = StateNotifierProvider<AiChatNotifier, bool>((ref) {
  return AiChatNotifier(ref);
});

class AiChatNotifier extends StateNotifier<bool> {
  AiChatNotifier(this.ref) : super(false);

  final Ref ref;

  Future<AiChatResponse> ask({
    required String farmId,
    required String message,
  }) async {
    state = true;

    try {
      final repo = ref.read(aiChatRepositoryProvider);

      final reply = await repo.askAssistant(farmId: farmId, message: message);

      return reply;
    } finally {
      state = false;
    }
  }
}
