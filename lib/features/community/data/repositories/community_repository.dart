import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/community_question_model.dart';
import '../models/traffic_report_model.dart';
import '../models/community_reply_model.dart';

class CommunityRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<CommunityQuestionModel>> getQuestions() async {
    try {
      final data = await _supabase
          .from('community_questions')
          .select()
          .order('created_at', ascending: false);

      return (data as List)
          .map((json) => CommunityQuestionModel.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<TrafficReportModel>> getReports() async {
    try {
      final data = await _supabase
          .from('traffic_reports')
          .select()
          .order('created_at', ascending: false);

      return (data as List)
          .map((json) => TrafficReportModel.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> postQuestion(CommunityQuestionModel question) async {
    await _supabase.from('community_questions').insert(question.toJson());
  }

  Future<void> postReport(TrafficReportModel report) async {
    await _supabase.from('traffic_reports').insert(report.toJson());
  }

  // Reply methods
  Future<List<CommunityReplyModel>> getReplies(String questionId) async {
    try {
      final data = await _supabase
          .from('community_replies')
          .select()
          .eq('question_id', questionId)
          .order('created_at', ascending: true);

      return (data as List)
          .map((json) => CommunityReplyModel.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> postReply(CommunityReplyModel reply) async {
    print('🔵 Posting reply...');
    await _supabase.from('community_replies').insert(reply.toJson());
    print('✅ Reply posted successfully');

    // Increment answer count
    await incrementAnswerCount(reply.questionId);
  }

  Future<void> incrementAnswerCount(String questionId) async {
    print('🔵 Starting incrementAnswerCount for question: $questionId');

    try {
      // Get current count
      print('🔵 Fetching current answer_count...');
      final result = await _supabase
          .from('community_questions')
          .select('answer_count')
          .eq('id', questionId)
          .maybeSingle();

      print('🔵 Query result: $result');

      if (result != null) {
        final currentCount = (result['answer_count'] as int?) ?? 0;
        print('🔵 Current count: $currentCount');

        final newCount = currentCount + 1;
        print('🔵 Updating to new count: $newCount');

        // Update with incremented value
        final updateResult = await _supabase
            .from('community_questions')
            .update({'answer_count': newCount})
            .eq('id', questionId)
            .select();

        print('✅ Successfully incremented! Update result: $updateResult');
      } else {
        print('❌ Question not found: $questionId');
      }
    } catch (e, stackTrace) {
      print('❌ Error incrementing answer count: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
