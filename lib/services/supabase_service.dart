import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jobtrack/models/job_application.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  // SELECT * FROM applications ORDER BY applied_date DESC;
  Future<List<JobApplication>> loadApplications() async {
    final rows = await _client
        .from('applications')
        .select()
        .order('applied_date', ascending: false);
    return rows.map((row) => JobApplication.fromJson(row)).toList();
  }

  // SELECT * FROM applications WHERE status = 'Interviewing';
  Future<List<JobApplication>> loadByStatus(String status) async {
    final rows = await _client
        .from('applications')
        .select()
        .eq('status', status);
    return rows.map((row) => JobApplication.fromJson(row)).toList();
  }

  Future<void> addApplication(JobApplication app) async {
    await _client.from('applications').insert(app.toJson());
  }

  Future<void> updateStatus(String id, String newStatus) async {
    await _client
        .from('applications')
        .update({'status': newStatus})
        .eq('id', id);
  }
}
