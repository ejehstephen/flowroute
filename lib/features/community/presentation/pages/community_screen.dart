import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../providers/community_providers.dart';
import '../widgets/community_post_card.dart';
import '../widgets/filter_chip_row.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(filteredCommunityPostsProvider);
    final selectedFilter = ref.watch(communityFilterProvider);

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
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        centerTitle: true,
        title: Text(
          'Community Q&A',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/community/ask'),
        backgroundColor: const Color(0xFF2962FF),
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E24),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                style: GoogleFonts.outfit(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search questions...',
                  hintStyle: GoogleFonts.outfit(color: Colors.white38),
                  prefixIcon: const Icon(Icons.search, color: Colors.white38),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),

          // Filter Chips
          FilterChipRow(
            selectedFilter: selectedFilter,
            onFilterSelected: (filter) {
              ref.read(communityFilterProvider.notifier).state = filter;
            },
          ),

          const SizedBox(height: 8),

          // Post List
          Expanded(
            child: postsAsync.when(
              data: (posts) {
                if (posts.isEmpty) {
                  return Center(
                    child: Text(
                      'No posts yet. Be the first to post!',
                      style: GoogleFonts.outfit(color: Colors.white70),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return CommunityPostCard(post: posts[index]);
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              ),
              error: (error, stack) => Center(
                child: Text(
                  'Error loading posts',
                  style: GoogleFonts.outfit(color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
