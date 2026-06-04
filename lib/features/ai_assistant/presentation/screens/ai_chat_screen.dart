import 'package:flock_pilot/provider/ai_assistant_provider.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flock_pilot/shared/models/ai_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key, required this.farmId});

  final String farmId;

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();

  String? conversationId;

  bool isLoadingMessages = false;

  final List<ChatMessageModel> messages = [];

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final farm = ref.read(farmProvider).farm;

      conversationId = farm?.activeConversationId;

      if (conversationId != null) {
        await loadMessages();
      } else {
        setState(() {
          messages.add(
            ChatMessageModel(
              id: 'welcome',
              role: 'ASSISTANT',
              message:
                  'Hello 👋 I am CoopMind. How can I help your farm today?',
              createdAt: DateTime.now(),
              conversationId: '',
            ),
          );
        });
      }
    });
  }

  Future<void> loadMessages() async {
    if (conversationId == null) return;

    setState(() {
      isLoadingMessages = true;
    });

    try {
      final data = await ref
          .read(aiChatProvider.notifier)
          .getMessages(farmId: widget.farmId, conversationId: conversationId!);

      if (!mounted) return;

      setState(() {
        messages.clear();
        messages.addAll(data);
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoadingMessages = false;
        });
      }
    }
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    _controller.clear();

    // optimistic user message
    setState(() {
      messages.add(
        ChatMessageModel(
          id: DateTime.now().toIso8601String(),
          role: 'USER',
          message: text,
          createdAt: DateTime.now(),
          conversationId: conversationId ?? '',
        ),
      );
    });

    try {
      final response = await ref
          .read(aiChatProvider.notifier)
          .ask(
            farmId: widget.farmId,
            message: text,
            conversationId: conversationId,
          );

      // refresh farm state so activeConversationId updates
      await ref.read(farmProvider.notifier).loadFarm(widget.farmId);

      if (!mounted) return;

      setState(() {
        // local state update
        conversationId = response.conversationId;

        messages.add(
          ChatMessageModel(
            id: DateTime.now().toIso8601String(),
            role: 'ASSISTANT',
            message: response.message,
            createdAt: DateTime.now(),
            conversationId: response.conversationId,
          ),
        );
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget _buildMessage(ChatMessageModel message) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? Colors.green.shade600 : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: isUser ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ask CoopMind...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),

          const SizedBox(width: 8),

          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(aiChatProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('CoopMind AI')),

      body: Column(
        children: [
          Expanded(
            child: isLoadingMessages
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessage(messages[index]);
                    },
                  ),
          ),

          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text("AI is thinking... 🤖"),
            ),

          _buildInput(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
