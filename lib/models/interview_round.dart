class InterviewRound {
  final String? id;
  final String applicationId;
  String roundName;
  DateTime? roundDate;
  String? outcome;

  InterviewRound({
    this.id,
    required this.applicationId,
    required this.roundName,
    this.roundDate,
    this.outcome,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'application_id': applicationId,
      'round_name': roundName,
      'round_date': roundDate?.toIso8601String().split('T')[0],
      'outcome': outcome,
    };
  }

  factory InterviewRound.fromJson(Map<String, dynamic> json) {
    return InterviewRound(
      id: json['id'] as String?,
      applicationId: json['application_id'],
      roundName: json['round_name'],
      roundDate: json['round_date'] != null
          ? DateTime.parse(json['round_date'])
          : null,
      outcome: json['outcome'],
    );
  }
}
