import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/community_providers.dart';

class CommunityPostCard extends StatelessWidget {
  final CommunityPost post;

  const CommunityPostCard({super.key, required this.post});

  Color _getSeverityColor(TrafficSeverity severity) {
    switch (severity) {
      case TrafficSeverity.severe:
        return const Color(0xFFCF6679); // Red-ish
      case TrafficSeverity.moderate:
        return const Color(0xFFFFB74D); // Orange-ish
      case TrafficSeverity.light:
        return const Color(0xFF81C784); // Green-ish
    }
  }

  String _getSeverityLabel(TrafficSeverity severity) {
    return severity.name.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final severityColor = _getSeverityColor(post.severity);

    return GestureDetector(
      onTap: () => context.go('/community/details/${post.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E24),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Colored Left Border
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: severityColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 16,
                            backgroundColor: Color(0xFF2D2D3A),
                            child: Icon(
                              Icons.person,
                              color: Colors.white54,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.userName,
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                post.timeAgo,
                                style: GoogleFonts.outfit(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Type Badge (Question or Report)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: post.isReport
                              ? const Color(0xFFCF6679).withOpacity(0.2)
                              : const Color(0xFF2962FF).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              post.isReport
                                  ? Icons.warning_amber_rounded
                                  : Icons.question_answer_rounded,
                              size: 14,
                              color: post.isReport
                                  ? const Color(0xFFCF6679)
                                  : const Color(0xFF2962FF),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              post.isReport ? 'Report' : 'Question',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: post.isReport
                                    ? const Color(0xFFCF6679)
                                    : const Color(0xFF2962FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Question
                      Text(
                        post.question,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Footer (Badge & Replies)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Only show severity badge for reports
                          if (post.isReport)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: severityColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _getSeverityLabel(post.severity),
                                style: GoogleFonts.outfit(
                                  color: severityColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          Row(
                            children: [
                              const Icon(
                                Icons.chat_bubble_outline_rounded,
                                color: Colors.white54,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${post.replyCount} Replies',
                                style: GoogleFonts.outfit(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
