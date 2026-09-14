import 'package:flutter/material.dart';
import 'package:jobtrack/services/job_api_service.dart';
import 'package:jobtrack/screens/add_application_screen.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  late Future<List<JobListing>> _jobsFuture;

  @override
  void initState() {
    super.initState();
    _jobsFuture = fetchJobListings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Search')),
      body: FutureBuilder<List<JobListing>>(
        future: _jobsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final jobs = snapshot.data!;
          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return ListTile(
                title: Text(job.title),
                subtitle: Text('${job.companyName} . ${job.location}'),
                trailing: job.remote
                    ? const Icon(Icons.home_work, size: 18)
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddApplicationScreen(
                        initialCompany: job.companyName,
                        initialRole: job.title,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
