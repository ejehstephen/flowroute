class TrafficReportModel {
  final String id;
  final String? reporterId;
  final String reporterName;
  final String
  reportType; // 'Heavy Traffic', 'Accident', 'Road Block', 'Construction'
  final String? description;
  final String? location;
  final String? imageUrl;
  final String severity; // 'Heavy', 'Medium', 'Light'
  final DateTime createdAt;
  final DateTime? expiresAt;

  TrafficReportModel({
    required this.id,
    this.reporterId,
    required this.reporterName,
    required this.reportType,
    this.description,
    this.location,
    this.imageUrl,
    required this.severity,
    required this.createdAt,
    this.expiresAt,
  });

  factory TrafficReportModel.fromJson(Map<String, dynamic> json) {
    return TrafficReportModel(
      id: json['id'],
      reporterId: json['reporter_id'],
      reporterName: json['reporter_name'] ?? 'Guest',
      reportType: json['report_type'],
      description: json['description'],
      location: json['location'],
      imageUrl: json['image_url'],
      severity: json['severity'],
      createdAt: DateTime.parse(json['created_at']),
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reporter_id': reporterId,
      'reporter_name': reporterName,
      'report_type': reportType,
      'description': description,
      'location': location,
      'image_url': imageUrl,
      'severity': severity,
    };
  }
}
