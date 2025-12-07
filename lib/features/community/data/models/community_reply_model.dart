class CommunityReplyModel {
  final String id;
  final String questionId;
  final String? replierId;
  final String replierName;
  final String replyText;
  final bool isAiAssisted;
  final DateTime createdAt;

  CommunityReplyModel({
    required this.id,
    required this.questionId,
    this.replierId,
    required this.replierName,
    required this.replyText,
    this.isAiAssisted = false,
    required this.createdAt,
  });

  factory CommunityReplyModel.fromJson(Map<String, dynamic> json) {
    return CommunityReplyModel(
      id: json['id'],
      questionId: json['question_id'],
      replierId: json['replier_id'],
      replierName: json['replier_name'] ?? 'Guest',
      replyText: json['reply_text'],
      isAiAssisted: json['is_ai_assisted'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'replier_id': replierId,
      'replier_name': replierName,
      'reply_text': replyText,
      'is_ai_assisted': isAiAssisted,
    };
  }
}
