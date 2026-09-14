import 'package:flutter/material.dart';
import 'package:jobtrack/models/job_application.dart';
import 'package:jobtrack/services/storage_service.dart';

class ApplicationsProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  List<JobApplication> _applications = [];

  List<JobApplication> get applications => _applications;

  ApplicationsProvider() {
    _loadApplications();
  }

  Future<void> _loadApplications() async {
    _applications = await _storageService.loadApplictaions();
    notifyListeners();
  }

  void addApplication(JobApplication app) {
    _applications.add(app);
    notifyListeners();
    _storageService.saveApplications(_applications);
  }

  void updateStatus(int index, String newStatus) {
    _applications[index].status = newStatus;
    notifyListeners();
    _storageService.saveApplications(_applications);
  }
}
