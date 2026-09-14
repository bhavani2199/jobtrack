import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jobtrack/models/job_application.dart';

class StorageService {
  static const _key = 'job_applications';

  Future<void> saveApplications(List<JobApplication> applications) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = applications.map((app) => app.toJson()).toList();
    await prefs.setString(_key, json.encode(jsonList));
  }

  Future<List<JobApplication>> loadApplictaions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((item) => JobApplication.fromJson(item)).toList();
  }
}
