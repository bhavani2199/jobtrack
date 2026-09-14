import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobtrack/screens/application_list_screen.dart';
import 'package:jobtrack/providers/applications_provider.dart';

void main() {
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
