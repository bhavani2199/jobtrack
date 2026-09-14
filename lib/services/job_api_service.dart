import 'dart:convert';
import 'package:http/http.dart' as http;

class JobListing {
  final String title;
  final String companyName;
  final String location;
  final bool remote;

  JobListing({
    required this.title,
    required this.companyName,
    required this.location,
    required this.remote,
  });

  factory JobListing.fromJson(Map<String, dynamic> json) {
    return JobListing(
      title: json['title'] ?? '',
      companyName: json['company_name'] ?? '',
      location: json['location'] ?? '',
      remote: json['remote'] ?? false,
    );
  }
}

Future<List<JobListing>> fetchJobListings() async {
  final response = await http.get(
    Uri.parse('https://www.arbeitnow.com/api/job-board-api'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> body = json.decode(response.body);
    final List<dynamic> data = body['data'];
    return data.map((item) => JobListing.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load job listings');
  }
}
