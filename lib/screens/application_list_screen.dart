import 'package:flutter/material.dart';
import 'package:jobtrack/models/job_application.dart';

class ApplicationListScreen extends StatelessWidget {
  const ApplicationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<JobApplication> applications = [
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
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('JobTrack')),
      body: ListView.builder(
        itemCount: applications.length,
        itemBuilder: (context, index) {
          final app = applications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.role,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        app.company,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Chip(
                    label: Text(app.status),
                    backgroundColor: Colors.blue.shade50,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
