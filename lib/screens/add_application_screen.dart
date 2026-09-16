import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobtrack/providers/applications_provider.dart';
import 'package:jobtrack/models/job_application.dart';

class AddApplicationScreen extends StatefulWidget {
  final String? initialCompany;
  final String? initialRole;

  const AddApplicationScreen({
    super.key,
    this.initialCompany,
    this.initialRole,
  });

  @override
  State<AddApplicationScreen> createState() => _AddApplicationScreenState();
}

class _AddApplicationScreenState extends State<AddApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _companyController = TextEditingController();
  late final _roleController = TextEditingController();
  String _status = 'Applied';
  final DateTime _dateApplied = DateTime.now();

  @override
  void initState() {
    super.initState();
    _companyController.text = widget.initialCompany ?? '';
    _roleController.text = widget.initialRole ?? '';
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final newApp = JobApplication(
        company: _companyController.text,
        role: _roleController.text,
        status: _status,
        dateApplied: _dateApplied,
      );
      context.read<ApplicationsProvider>().addApplication(newApp);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Application')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(labelText: 'Company'),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Company is required'
                    : null,
              ),
              TextFormField(
                controller: _roleController,
                decoration: const InputDecoration(labelText: 'Role'),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Role is required'
                    : null,
              ),
              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Applied', 'Interviewing', 'Offer', 'Rejected']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
