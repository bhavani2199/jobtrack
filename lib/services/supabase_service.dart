import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jobtrack/models/job_application.dart';
import 'package:jobtrack/models/interview_round.dart';

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

  Future<List<InterviewRound>> loadRoundsForApplication(
    String applicationId,
  ) async {
    final rows = await _client
        .from('interview_rounds')
        .select()
        .eq('application_id', applicationId)
        .order('round_date');
    return rows.map((row) => InterviewRound.fromJson(row)).toList();
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

  Future<void> addRound(InterviewRound round) async {
    await _client.from('interview_rounds').insert(round.toJson());
  }
}
