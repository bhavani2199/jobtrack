import 'package:flutter/material.dart';
import 'package:jobtrack/models/job_application.dart';

class ApplicationsProvider extends ChangeNotifier {
  final List<JobApplication> _applications = [
    JobApplication(
      company: 'Google',
      role: 'Flutter Developer',
      status: 'Applied',
      dateApplied: DateTime(2026, 9, 1),
    ),
    JobApplication(
      company: 'Shopee',
      role: 'Mobile Engineer',
      status: 'Interviewing',
      dateApplied: DateTime(2026, 9, 5),
    ),
    JobApplication(
      company: 'Grab',
      role: 'Software Engineer',
      status: 'Offer',
      dateApplied: DateTime(2026, 9, 8),
    ),
    JobApplication(
      company: 'Facebook',
      role: 'Backend Developer',
      status: 'Rejected',
      dateApplied: DateTime(2026, 9, 10),
    ),
  ];

  List<JobApplication> get applications => _applications;

  void addApplication(JobApplication app) {
    _applications.add(app);
    notifyListeners();
  }

  void updateStatus(int index, String newStatus) {
    _applications[index].status = newStatus;
    notifyListeners();
  }
}
