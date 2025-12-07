import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../profile/presentation/providers/profile_providers.dart';
import '../../data/models/community_reply_model.dart';
import '../providers/community_providers.dart';
import '../widgets/reply_card.dart';

class QuestionDetailsScreen extends ConsumerStatefulWidget {
  final String postId;

  const QuestionDetailsScreen({super.key, required this.postId});

  @override
  ConsumerState<QuestionDetailsScreen> createState() =>
      _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends ConsumerState<QuestionDetailsScreen> {
  final _replyController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  Color _getSeverityColor(TrafficSeverity severity) {
    switch (severity) {
      case TrafficSeverity.severe:
        return const Color(0xFFCF6679);
      case TrafficSeverity.moderate:
        return const Color(0xFFFFB74D);
      case TrafficSeverity.light:
        return const Color(0xFF81C784);
    }
  }

  String _getSeverityLabel(TrafficSeverity severity) {
    switch (severity) {
      case TrafficSeverity.severe:
        return 'Heavy Traffic';
      case TrafficSeverity.moderate:
        return 'Moderate Traffic';
      case TrafficSeverity.light:
        return 'Light Traffic';
    }
  }

  Future<void> _submitReply() async {
    final text = _replyController.text.trim();
    if (text.isEmpty) return;

    setState(() => _isSubmitting = true);

    try {
      final user = ref.watch(currentUserProvider);
      final profile = await ref.watch(profileProvider.future);

      if (user == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please log in to reply')),
          );
        }
        setState(() => _isSubmitting = false);
        return;
      }

      final reply = CommunityReplyModel(
        id: '',
        questionId: widget.postId,
        replierId: user.id,
        replierName: profile?.username ?? 'User',
        replyText: text,
        createdAt: DateTime.now(),
      );

      await ref.read(communityRepositoryProvider).postReply(reply);

      // Wait for database to update
      await Future.delayed(const Duration(milliseconds: 800));

      // Force refresh all providers
      ref.invalidate(communityQuestionsProvider);
      ref.invalidate(repliesProvider(widget.postId));
      ref.invalidate(communityPostsProvider);

      _replyController.clear();

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Reply posted!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(communityPostsProvider);
    final repliesAsync = ref.watch(repliesProvider(widget.postId));

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
        centerTitle: true,
        title: Text(
          'Question Details',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: postsAsync.when(
        data: (posts) {
          if (posts.isEmpty) {
            return Center(
              child: Text(
                'No posts available',
                style: GoogleFonts.outfit(color: Colors.white70),
              ),
            );
          }

          final post = posts.firstWhere(
            (p) => p.id == widget.postId,
            orElse: () => posts.first,
          );

          final severityColor = _getSeverityColor(post.severity);

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Original Post
                      Container(
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
                                  radius: 18,
                                  backgroundColor: Color(0xFF2D2D3A),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white54,
                                    size: 22,
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
                                        fontSize: 16,
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
                            const SizedBox(height: 16),
                            Text(
                              post.question,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                            if (post.isReport) ...[
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: severityColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.warning_amber_rounded,
                                          color: severityColor,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          _getSeverityLabel(post.severity),
                                          style: GoogleFonts.outfit(
                                            color: severityColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Only show replies section for questions
                      if (!post.isReport) ...[
                        Text(
                          'Replies (${post.replyCount})',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        repliesAsync.when(
                          data: (replies) {
                            if (replies.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Text(
                                    'No replies yet. Be the first!',
                                    style: GoogleFonts.outfit(
                                      color: Colors.white54,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Column(
                              children: replies
                                  .map((reply) => ReplyCard(reply: reply))
                                  .toList(),
                            );
                          },
                          loading: () => const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: CircularProgressIndicator(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          error: (error, stack) => Center(
                            child: Text(
                              'Error loading replies',
                              style: GoogleFonts.outfit(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              // Input Bar - Only show for questions
              if (!post.isReport)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E1E24),
                    border: Border(
                      top: BorderSide(color: Color.fromARGB(26, 99, 98, 98)),
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF121212),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: TextField(
                              controller: _replyController,
                              style: GoogleFonts.outfit(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Add a reply...',
                                hintStyle: GoogleFonts.outfit(
                                  color: Colors.white38,
                                ),
                                border: InputBorder.none,
                              ),
                              enabled: !_isSubmitting,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF2962FF),
                            shape: BoxShape.circle,
                          ),
                          child: _isSubmitting
                              ? const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: _submitReply,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.blueAccent),
        ),
        error: (error, stack) => Center(
          child: Text(
            'Error loading post',
            style: GoogleFonts.outfit(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
