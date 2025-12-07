import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../providers/ai_chat_providers.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/suggestion_chip.dart';

class AIChatScreen extends ConsumerStatefulWidget {
  const AIChatScreen({super.key});

  @override
  ConsumerState<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends ConsumerState<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    ref.read(chatMessagesProvider.notifier).addMessage(_controller.text);
    _controller.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        ref
            .read(chatMessagesProvider.notifier)
            .addMessage(
              "I'm analyzing the traffic data for you. Please wait a moment.",
              isUser: false,
            );
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            const Icon(Icons.smart_toy_rounded, color: Color(0xFF2962FF)),
            const SizedBox(width: 8),
            Text(
              'FlowRoute AI',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Suggestion Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                SuggestionChipWidget(
                  label: 'Best route to work',
                  onTap: () => _controller.text = 'Best route to work',
                ),
                SuggestionChipWidget(
                  label: 'Traffic near me',
                  onTap: () => _controller.text = 'Traffic near me',
                ),
                SuggestionChipWidget(
                  label: 'Safe alternatives',
                  onTap: () => _controller.text = 'Safe alternatives',
                ),
              ],
            ),
          ),

          // Chat Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return ChatBubble(
                  message: msg.text,
                  isUser: msg.isUser,
                  timestamp: msg.timestamp,
                );
              },
            ),
          ),

          // Input Bar
          ChatInputBar(controller: _controller, onSend: _sendMessage),
        ],
      ),
    );
  }
}
