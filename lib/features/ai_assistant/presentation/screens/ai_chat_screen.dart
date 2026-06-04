import 'package:flock_pilot/provider/ai_assistant_provider.dart';
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

  final List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();

    messages.add({
      'isUser': false,
      'text': 'Hello 👋 I am CoopMind. How can I help your farm today?',
    });
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({'isUser': true, 'text': text});
      messages.add({'isUser': false, 'text': 'Thinking... 🤖'});
    });

    _controller.clear();

    try {
      final reply = await ref
          .read(aiChatProvider.notifier)
          .ask(farmId: widget.farmId, message: text);

      setState(() {
        messages.removeLast(); // remove "Thinking..."
        messages.add({'isUser': false, 'text': reply.message});
      });
    } catch (e) {
      setState(() {
        messages.removeLast();
        messages.add({
          'isUser': false,
          'text': 'Failed to get response. Try again.',
        });
      });
    }
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final isUser = message['isUser'] as bool;

    // if (farmId == null) {
    //   return FarmFallbackScreen(
    //     title: "No farm found",
    //     message: "Create a farm to start tracking performance.",
    //     icon: FontAwesomeIcons.tractor,
    //     onRetry: () {},
    //   );
    // }

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? Colors.green : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message['text'],
          style: TextStyle(color: isUser ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(aiChatProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('CoopMind AI')),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
}
