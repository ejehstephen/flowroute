import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/community_question_model.dart';
import '../../data/models/traffic_report_model.dart';
import '../../data/repositories/community_repository.dart';

enum TrafficSeverity { severe, moderate, light }

class Reply {
  final String id;
  final String userName;
  final String timeAgo;
  final String text;
  final int likes;
  final int dislikes;
  final String? userAvatarUrl;

  Reply({
    required this.id,
    required this.userName,
    required this.timeAgo,
    required this.text,
    required this.likes,
    required this.dislikes,
    this.userAvatarUrl,
  });
}

// Combined post type for UI
class CommunityPost {
  final String id;
  final String userName;
  final String timeAgo;
  final String question;
  final TrafficSeverity severity;
  final int replyCount;
  final String? userAvatarUrl;
  final List<Reply> replies;
  final bool isReport; // true if traffic report, false if question

  CommunityPost({
    required this.id,
    required this.userName,
    required this.timeAgo,
    required this.question,
    required this.severity,
    required this.replyCount,
    this.userAvatarUrl,
    this.replies = const [],
    this.isReport = false,
  });
}

enum CommunityFilter { all, severe, moderate, light }

final communityFilterProvider = StateProvider<CommunityFilter>(
  (ref) => CommunityFilter.all,
);

final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  return CommunityRepository();
});

final communityQuestionsProvider = FutureProvider<List<CommunityQuestionModel>>(
  (ref) async {
    return ref.watch(communityRepositoryProvider).getQuestions();
  },
);

final trafficReportsProvider = FutureProvider<List<TrafficReportModel>>((
  ref,
) async {
  return ref.watch(communityRepositoryProvider).getReports();
});

// Replies provider - takes questionId as parameter
final repliesProvider = FutureProvider.family<List<Reply>, String>((
  ref,
  questionId,
) async {
  final repository = ref.watch(communityRepositoryProvider);
  final replies = await repository.getReplies(questionId);

  // Convert to UI Reply model
  return replies.map((r) {
    return Reply(
      id: r.id,
      userName: r.replierName,
      timeAgo: _timeAgo(r.createdAt),
      text: r.replyText,
      likes: 0, // TODO: Implement likes
      dislikes: 0, // TODO: Implement dislikes
    );
  }).toList();
});

// Helper to convert severity string to enum
TrafficSeverity _parseSeverity(String severity) {
  switch (severity.toLowerCase()) {
    case 'heavy':
      return TrafficSeverity.severe;
    case 'medium':
      return TrafficSeverity.moderate;
    case 'light':
      return TrafficSeverity.light;
    default:
      return TrafficSeverity.light;
  }
}

// Helper to calculate time ago
String _timeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays}d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m ago';
  } else {
    return 'Just now';
  }
}

// Combined provider that merges questions and reports
final communityPostsProvider = FutureProvider<List<CommunityPost>>((ref) async {
  final questionsAsync = ref.watch(communityQuestionsProvider);
  final reportsAsync = ref.watch(trafficReportsProvider);

  final questions = questionsAsync.maybeWhen(
    data: (data) => data,
    orElse: () => <CommunityQuestionModel>[],
  );

  final reports = reportsAsync.maybeWhen(
    data: (data) => data,
    orElse: () => <TrafficReportModel>[],
  );

  final List<CommunityPost> posts = [];

  // Add questions (default to Light severity for UI purposes)
  for (var q in questions) {
    posts.add(
      CommunityPost(
        id: q.id,
        userName: q.askerName,
        timeAgo: _timeAgo(q.createdAt),
        question: q.questionText,
        severity: TrafficSeverity.light, // Questions don't have severity
        replyCount: q.answerCount,
        isReport: false,
      ),
    );
  }

  // Add reports
  for (var r in reports) {
    posts.add(
      CommunityPost(
        id: r.id,
        userName: r.reporterName,
        timeAgo: _timeAgo(r.createdAt),
        question: '${r.reportType}: ${r.description ?? "No description"}',
        severity: _parseSeverity(r.severity),
        replyCount: 0,
        isReport: true,
      ),
    );
  }

  // Sort by creation time (newest first)
  posts.sort((a, b) => b.timeAgo.compareTo(a.timeAgo));

  return posts;
});

final filteredCommunityPostsProvider =
    Provider<AsyncValue<List<CommunityPost>>>((ref) {
      final filter = ref.watch(communityFilterProvider);
      final postsAsync = ref.watch(communityPostsProvider);

      return postsAsync.whenData((posts) {
        if (filter == CommunityFilter.all) {
          return posts;
        }

        return posts.where((post) {
          switch (filter) {
            case CommunityFilter.severe:
              return post.severity == TrafficSeverity.severe;
            case CommunityFilter.moderate:
              return post.severity == TrafficSeverity.moderate;
            case CommunityFilter.light:
              return post.severity == TrafficSeverity.light;
            default:
              return true;
          }
        }).toList();
      });
    });
