class CommunityQuestionModel {
  final String id;
  final String? askerId;
  final String askerName;
  final String questionText;
  final String? location;
  final String? imageUrl;
  final int answerCount;
  final DateTime createdAt;

  CommunityQuestionModel({
    required this.id,
    this.askerId,
    required this.askerName,
    required this.questionText,
    this.location,
    this.imageUrl,
    this.answerCount = 0,
    required this.createdAt,
  });

  factory CommunityQuestionModel.fromJson(Map<String, dynamic> json) {
    return CommunityQuestionModel(
      id: json['id'],
      askerId: json['asker_id'],
      askerName: json['asker_name'] ?? 'Guest',
      questionText: json['question_text'],
      location: json['location'],
      imageUrl: json['image_url'],
      answerCount: json['answer_count'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asker_id': askerId,
      'asker_name': askerName,
      'question_text': questionText,
      'location': location,
      'image_url': imageUrl,
      'answer_count': answerCount,
    };
  }
}
