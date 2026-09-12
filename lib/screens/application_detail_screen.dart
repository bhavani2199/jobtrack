import 'package:flutter/material.dart';
import 'package:jobtrack/models/job_application.dart';

class ApplicationDetailScreen extends StatelessWidget {
  final JobApplication application;
  const ApplicationDetailScreen({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(application.role)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company: ${application.company}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${application.status}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Date Applied: ${application.dateApplied.toLocal().toString().split(' ')[0]}',
            ),
          ],
        ),
      ),
    );
  }
}
