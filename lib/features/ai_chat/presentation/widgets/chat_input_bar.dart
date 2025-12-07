import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E24),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_location_alt_rounded,
                color: Colors.white54,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D3A),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: controller,
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Message FlowRoute AI...',
                    hintStyle: GoogleFonts.outfit(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => onSend(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onSend,
              icon: const Icon(Icons.send_rounded, color: Color(0xFF2962FF)),
            ),
          ],
        ),
      ),
    );
  }
}
