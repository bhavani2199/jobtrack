import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobtrack/screens/application_detail_screen.dart';
import 'package:jobtrack/providers/applications_provider.dart';
import 'package:jobtrack/screens/add_application_screen.dart';
import 'package:jobtrack/screens/job_search_screen.dart';

class ApplicationListScreen extends StatelessWidget {
  const ApplicationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final applications = context.watch<ApplicationsProvider>().applications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('JobTrack'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JobSearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: applications.length,
        itemBuilder: (context, index) {
          final app = applications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ApplicationDetailScreen(application: app),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
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
                    ),
                    Chip(
                      label: Text(app.status),
                      backgroundColor: Colors.blue.shade50,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${app.rounds?.length ?? 0} rounds',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddApplicationScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
