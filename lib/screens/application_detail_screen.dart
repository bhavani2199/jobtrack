import 'package:flutter/material.dart';
import 'package:jobtrack/models/job_application.dart';
import 'package:jobtrack/models/interview_round.dart';
import 'package:jobtrack/services/supabase_service.dart';

class ApplicationDetailScreen extends StatefulWidget {
  final JobApplication application;
  const ApplicationDetailScreen({super.key, required this.application});

  @override
  State<ApplicationDetailScreen> createState() =>
      _ApplicationDetailScreenState();
}

class _ApplicationDetailScreenState extends State<ApplicationDetailScreen> {
  final _service = SupabaseService();
  final _roundNameController = TextEditingController();
  List<InterviewRound> _rounds = [];
  DateTime _selectedRoundDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadRounds();
  }

  Future<void> _loadRounds() async {
    final rounds = await _service.loadRoundsForApplication(
      widget.application.id!,
    );
    setState(() => _rounds = rounds);
  }

  Future<void> _addRound() async {
    if (_roundNameController.text.isEmpty) return;
    final round = InterviewRound(
      applicationId: widget.application.id!,
      roundName: _roundNameController.text,
      roundDate: DateTime.now(),
    );
    await _service.addRound(round);
    _roundNameController.clear();
    await _loadRounds();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedRoundDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedRoundDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.application.role)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company: ${widget.application.company}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${widget.application.status}',
              style: const TextStyle(fontSize: 18),
            ),
            const Divider(height: 32),
            const Text(
              'Interview Rounds',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ..._rounds.map(
              (r) => ListTile(
                title: Text(r.roundName),
                subtitle: Text(r.outcome ?? 'Pending'),
                onTap: () async {
                  final outcome = await showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: const Text('Mark Outcome'),
                      children: ['Passed', 'Failed', 'Pending']
                          .map(
                            (o) => SimpleDialogOption(
                              onPressed: () => Navigator.pop(context, o),
                              child: Text(o),
                            ),
                          )
                          .toList(),
                    ),
                  );
                  if (outcome != null) {
                    await _service.updateRoundOutcome(r.id!, outcome);
                    await _loadRounds();
                  }
                },
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: _pickDate,
                  child: Text(
                    _selectedRoundDate.toLocal().toString().split(' ')[0],
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _roundNameController,
                    decoration: const InputDecoration(labelText: 'Round name'),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: _addRound),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
