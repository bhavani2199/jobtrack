import 'package:jobtrack/models/interview_round.dart';

class JobApplication {
  final String? id;
  String company;
  String role;
  String status;
  DateTime dateApplied;
  final List<InterviewRound>? rounds;

  JobApplication({
    this.id,
    required this.company,
    required this.role,
    required this.status,
    required this.dateApplied,
    this.rounds,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'company_name': company,
      'role_title': role,
      'status': status,
      'applied_date': dateApplied.toIso8601String().split('T')[0],
    };
  }

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['id'] as String?,
      company: json['company_name'],
      role: json['role_title'],
      status: json['status'],
      dateApplied: DateTime.parse(json['applied_date']),
      rounds: json['interview_rounds'] != null
          ? (json['interview_rounds'] as List)
                .map((r) => InterviewRound.fromJson(r))
                .toList()
          : null,
    );
  }
}
