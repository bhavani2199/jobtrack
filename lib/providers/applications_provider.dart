import 'package:flutter/material.dart';
import 'package:jobtrack/models/job_application.dart';
import 'package:jobtrack/services/supabase_service.dart';

class ApplicationsProvider extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();
  List<JobApplication> _applications = [];

  List<JobApplication> get applications => _applications;

  ApplicationsProvider() {
    _loadApplications();
  }

  Future<void> _loadApplications() async {
    _applications = await _service.loadApplicationsWithRounds();
    notifyListeners();
  }

  Future<void> addApplication(JobApplication app) async {
    await _service.addApplication(app);
    await _loadApplications();
  }

  Future<void> updateStatus(String id, String newStatus) async {
    await _service.updateStatus(id, newStatus);
    await _loadApplications();
  }
}
