import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/community_providers.dart';

class ReplyCard extends StatelessWidget {
  final Reply reply;

  const ReplyCard({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFF2D2D3A),
                child: Icon(Icons.person, color: Colors.white54, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                reply.userName,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                reply.timeAgo,
                style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            reply.text,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.thumb_up_rounded,
                color: Colors.white54,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${reply.likes}',
                style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.thumb_down_rounded,
                color: Colors.white54,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${reply.dislikes}',
                style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
