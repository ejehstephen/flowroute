import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>((ref) {
      return ChatMessagesNotifier();
    });

class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  ChatMessagesNotifier()
    : super([
        ChatMessage(
          id: '1',
          text: 'Good morning! How can I help you navigate today?',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      ]);

  void addMessage(String text, {bool isUser = true}) {
    final message = ChatMessage(
      id: DateTime.now().toString(),
      text: text,
      isUser: isUser,
      timestamp: DateTime.now(),
    );
    state = [...state, message];
  }
}

final isTypingProvider = StateProvider<bool>((ref) => false);
