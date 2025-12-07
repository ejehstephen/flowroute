class ProfileModel {
  final String id;
  final String? username;
  final String? avatarUrl;
  final String? email;
  final bool privateModeEnabled;

  ProfileModel({
    required this.id,
    this.username,
    this.avatarUrl,
    this.email,
    bool? privateModeEnabled,
  }) : privateModeEnabled = privateModeEnabled ?? false;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      username: json['username'],
      avatarUrl: json['avatar_url'],
      email: json['email'],
      privateModeEnabled: json['private_mode_enabled'] ?? false,
    );
  }

  ProfileModel copyWith({
    String? id,
    String? username,
    String? avatarUrl,
    String? email,
    bool? privateModeEnabled,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      email: email ?? this.email,
      privateModeEnabled: privateModeEnabled ?? this.privateModeEnabled,
    );
  }
}
