class JobApplication {
  // id is the primary key (Topic 1). Supabase generates it — we never set it
  // ourselves when creating a new application, only when we already have one
  // loaded back from the database.
  final String? id;
  String company;
  String role;
  String status;
  DateTime dateApplied;

  JobApplication({
    this.id,
    required this.company,
    required this.role,
    required this.status,
    required this.dateApplied,
  });

  // Matches the actual Supabase column names (Topic 3: types & constraints —
  // this is the shape the database enforces).
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
    );
  }
}
