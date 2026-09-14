class JobApplication {
  String company;
  String role;
  String status;
  DateTime dateApplied;

  JobApplication({
    required this.company,
    required this.role,
    required this.status,
    required this.dateApplied,
  });

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'role': role,
      'status': status,
      'dateApplied': dateApplied.toIso8601String(),
    };
  }

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      company: json['company'],
      role: json['role'],
      status: json['status'],
      dateApplied: DateTime.parse(json['dateApplied']),
    );
  }
}
