import 'package:flutter/material.dart';
import 'package:jobtrack/screens/application_list_screen.dart';

void main() {
  runApp(const JobTrackApp());
}

class JobTrackApp extends StatelessWidget {
  const JobTrackApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const ApplicationListScreen());
  }
}
