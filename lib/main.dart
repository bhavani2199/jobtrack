import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jobtrack/screens/application_list_screen.dart';
import 'package:jobtrack/providers/applications_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://rnqgtufvbkdrvcnirunr.supabase.co',
    publishableKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJucWd0dWZ2YmtkcnZjbmlydW5yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODk0NjY5MDgsImV4cCI6MjEwNTA0MjkwOH0.1aQPrmXcEIjPaGT78gSPcSLfetqBFAzzN1LBOd5ovZY',
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationsProvider(),
      child: const JobTrackApp(),
    ),
  );
}

class JobTrackApp extends StatelessWidget {
  const JobTrackApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ApplicationListScreen(),
    );
  }
}
