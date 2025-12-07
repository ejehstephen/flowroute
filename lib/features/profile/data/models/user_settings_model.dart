class UserSettingsModel {
  final String userId;
  final bool trafficAlertsEnabled;
  final bool communityRepliesEnabled;
  final bool aiSuggestionsEnabled;
  final bool promotionsEnabled;
  final bool darkModeEnabled;

  UserSettingsModel({
    required this.userId,
    required this.trafficAlertsEnabled,
    required this.communityRepliesEnabled,
    required this.aiSuggestionsEnabled,
    required this.promotionsEnabled,
    required this.darkModeEnabled,
  });

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      userId: json['user_id'],
      trafficAlertsEnabled: json['traffic_alerts_enabled'] ?? true,
      communityRepliesEnabled: json['community_replies_enabled'] ?? true,
      aiSuggestionsEnabled: json['ai_suggestions_enabled'] ?? true,
      promotionsEnabled: json['promotions_enabled'] ?? true,
      darkModeEnabled: json['dark_mode_enabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'traffic_alerts_enabled': trafficAlertsEnabled,
      'community_replies_enabled': communityRepliesEnabled,
      'ai_suggestions_enabled': aiSuggestionsEnabled,
      'promotions_enabled': promotionsEnabled,
      'dark_mode_enabled': darkModeEnabled,
    };
  }

  UserSettingsModel copyWith({
    String? userId,
    bool? trafficAlertsEnabled,
    bool? communityRepliesEnabled,
    bool? aiSuggestionsEnabled,
    bool? promotionsEnabled,
    bool? darkModeEnabled,
  }) {
    return UserSettingsModel(
      userId: userId ?? this.userId,
      trafficAlertsEnabled: trafficAlertsEnabled ?? this.trafficAlertsEnabled,
      communityRepliesEnabled:
          communityRepliesEnabled ?? this.communityRepliesEnabled,
      aiSuggestionsEnabled: aiSuggestionsEnabled ?? this.aiSuggestionsEnabled,
      promotionsEnabled: promotionsEnabled ?? this.promotionsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
    );
  }
}
